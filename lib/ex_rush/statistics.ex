defmodule ExRush.Statistics do
  @moduledoc """
  The Statistics context.
  """

  import Ecto.Query, warn: false
  alias ExRush.Repo

  alias ExRush.Statistics.Statistic

  @doc """
  Returns the list of statistics.

  ## Examples

      iex> list_statistics()
      [%Statistic{}, ...]

  """
  def list_statistics do
    {_, statistics} =
      Cachex.fetch(__MODULE__, "all", fn ->
        {:commit, Repo.all(Statistic)}
      end)

    statistics
  end

  @doc """
  Returns the list of statistics filter by the player name.

  ## Examples

      iex> list_statistics_by(%{player: "some player"})
      [%Statistic{}, ...]
  """
  def list_statistics_by(%{player: player}) do
    query =
      from(statistic in Statistic,
        where:
          fragment(
            "to_tsvector('english', player) @@ to_tsquery(?)",
            ^prefix_search(player)
          )
      )

    Repo.all(query)
  end

  defp prefix_search(term), do: String.replace(term, ~r/\ /u, " & ") <> ":*"

  @doc """
  Returns the list of ordered by `order_by` statistics.

  ## Examples

      iex> list_statistics_by("player", "asc")
      [%Statistic{}, ...]

      iex> list_statistics_by("player", "desc")
      [%Statistic{}, ...]
  """
  def list_statistics_by(order_by, direction) do
    {_, statistics} =
      Cachex.fetch(__MODULE__, "#{order_by}-#{direction}", fn ->
        by = String.to_existing_atom(order_by)

        statistics =
          Statistic
          |> choose_order_by(by, direction)
          |> Repo.all()

        {:commit, statistics}
      end)

    statistics
  end

  @doc """
  Gets a single statistic.

  Raises `Ecto.NoResultsError` if the Statistic does not exist.

  ## Examples

      iex> get_statistic!(123)
      %Statistic{}

      iex> get_statistic!(456)
      ** (Ecto.NoResultsError)

  """
  def get_statistic!(id), do: Repo.get!(Statistic, id)

  @doc """
  Creates a statistic.

  ## Examples

      iex> create_statistic(%{field: value})
      {:ok, %Statistic{}}

      iex> create_statistic(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_statistic(attrs \\ %{}) do
    %Statistic{}
    |> Statistic.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Upserts a statistic. In case of conflict, no operation is done.

  ## Examples

      iex> upsert_statistic!(attrs)
      %Statistic{}
  """
  def upsert_statistic!(attrs \\ %{}) do
    %Statistic{}
    |> Statistic.changeset(attrs)
    |> Repo.insert!(on_conflict: :nothing)
  end

  @doc """
  Updates a statistic.

  ## Examples

      iex> update_statistic(statistic, %{field: new_value})
      {:ok, %Statistic{}}

      iex> update_statistic(statistic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_statistic(%Statistic{} = statistic, attrs) do
    statistic
    |> Statistic.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a statistic.

  ## Examples

      iex> delete_statistic(statistic)
      {:ok, %Statistic{}}

      iex> delete_statistic(statistic)
      {:error, %Ecto.Changeset{}}

  """
  def delete_statistic(%Statistic{} = statistic) do
    Repo.delete(statistic)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking statistic changes.

  ## Examples

      iex> change_statistic(statistic)
      %Ecto.Changeset{data: %Statistic{}}

  """
  def change_statistic(%Statistic{} = statistic, attrs \\ %{}) do
    Statistic.changeset(statistic, attrs)
  end

  defp choose_order_by(query, order_by, "asc") do
    order_by(query, asc: ^order_by)
  end

  defp choose_order_by(query, order_by, "desc") do
    order_by(query, desc: ^order_by)
  end
end
