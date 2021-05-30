defmodule ExRush.Statistics.Statistic do
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
    field :total_rushing_yards, :integer
    field :longest_rush, :string

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
      :longest_rush
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
      :longest_rush
    ])
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
        :longest_rush
      ],
      name: "stat_index"
    )
  end
end
