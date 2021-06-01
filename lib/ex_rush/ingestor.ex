defmodule ExRush.Ingestor do
  @moduledoc """
  Process responsible for loading `priv/data/rushing.json` file into Postgres.
  """

  use GenServer

  require Logger
  alias ExRush.Statistics

  def start_link(path) do
    GenServer.start_link(__MODULE__, path, name: __MODULE__)
  end

  def init(path) do
    {:ok, path, 0}
  end

  def handle_info(:timeout, path) do
    :ok =
      path
      |> File.read!()
      |> Jason.decode!()
      |> Enum.each(fn statistic ->
        statistic
        |> format_params()
        |> Statistics.upsert_statistic!()
      end)

    {:noreply, path}
  end

  defp format_params(statistic) do
    %{
      player: statistic["Player"],
      position: statistic["Pos"],
      rushing_20: statistic["20+"],
      rushing_40: statistic["40+"],
      rushing_attempts: statistic["Att"],
      rushing_attempts_per_game_average: statistic["Att/G"],
      rushing_average_yards_per_attempt: statistic["Avg"],
      rushing_first_down_percentage: statistic["1st%"],
      rushing_first_downs: statistic["1st"],
      rushing_fumbles: statistic["FUM"],
      rushing_yards_per_game: statistic["Yds/G"],
      team: statistic["Team"],
      total_rushing_touchdowns: statistic["TD"],
      total_rushing_yards: statistic["Yds"],
      longest_rush_with_touchdown: statistic["Lng"]
    }
  end
end
