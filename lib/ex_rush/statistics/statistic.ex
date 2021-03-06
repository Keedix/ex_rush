defmodule ExRush.Statistics.Statistic do
  @moduledoc """
  Statistic model
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "statistics" do
    field :player, :string
    field :position, :string
    field :rushing_20, :integer
    field :rushing_40, :integer
    field :rushing_attempts, :integer
    field :rushing_attempts_per_game_average, :float
    field :rushing_average_yards_per_attempt, :float
    field :rushing_first_down_percentage, :float
    field :rushing_first_downs, :integer
    field :rushing_fumbles, :integer
    field :rushing_yards_per_game, :float
    field :team, :string
    field :total_rushing_touchdowns, :integer
    field :total_rushing_yards, ExRush.Types.MaybeFloat
    field :longest_rush, :integer
    field :is_longest_rush_touchdown, :boolean, default: false

    field :longest_rush_with_touchdown, ExRush.Types.MaybeString, virtual: true

    timestamps()
  end

  @doc false
  def changeset(statistic, attrs) do
    statistic
    |> cast(attrs, [
      :player,
      :team,
      :position,
      :rushing_attempts_per_game_average,
      :rushing_attempts,
      :total_rushing_yards,
      :rushing_average_yards_per_attempt,
      :rushing_yards_per_game,
      :total_rushing_touchdowns,
      :rushing_first_downs,
      :rushing_first_down_percentage,
      :rushing_20,
      :rushing_40,
      :rushing_fumbles,
      :longest_rush_with_touchdown
    ])
    |> validate_required([
      :player,
      :team,
      :position,
      :rushing_attempts_per_game_average,
      :rushing_attempts,
      :total_rushing_yards,
      :rushing_average_yards_per_attempt,
      :rushing_yards_per_game,
      :total_rushing_touchdowns,
      :rushing_first_downs,
      :rushing_first_down_percentage,
      :rushing_20,
      :rushing_40,
      :rushing_fumbles,
      :longest_rush_with_touchdown
    ])
    |> change_longest_rush()
    |> unique_constraint(
      [
        :player,
        :team,
        :position,
        :rushing_attempts_per_game_average,
        :rushing_attempts,
        :total_rushing_yards,
        :rushing_average_yards_per_attempt,
        :rushing_yards_per_game,
        :total_rushing_touchdowns,
        :rushing_first_downs,
        :rushing_first_down_percentage,
        :rushing_20,
        :rushing_40,
        :rushing_fumbles,
        :longest_rush,
        :is_longest_rush_touchdown
      ],
      name: "stat_index"
    )
  end

  defp change_longest_rush(changeset) do
    changeset
    |> get_field(:longest_rush_with_touchdown)
    |> change_longest_rush(changeset)
  end

  defp change_longest_rush(longest_rush, changeset) when is_nil(longest_rush), do: changeset
  defp change_longest_rush(longest_rush, changeset) when is_integer(longest_rush), do: changeset

  defp change_longest_rush(longest_rush, changeset) when is_binary(longest_rush) do
    {number, touchdown?} =
      case Regex.run(~r/(.*)(T)/, longest_rush) do
        nil ->
          {longest_rush, false}

        [^longest_rush, number, _touchdown] ->
          {number, true}
      end

    changeset
    |> put_change(:longest_rush, String.to_integer(number))
    |> put_change(:is_longest_rush_touchdown, touchdown?)
  end
end
