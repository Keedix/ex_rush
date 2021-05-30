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
    Repo.all(Statistic)
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
end
