defmodule ExRushWeb.CsvView do
  use ExRushWeb, :view

  alias ExRush.Statistics.Statistic

  def render("report.csv", %{statistics: statistics}) do
    csv =
      [create_headers() | statistics]
      |> Stream.map(&to_csv/1)
      |> CSV.encode()
      |> Enum.to_list()

    csv
  end

  defp create_headers() do
    [
      gettext("Player"),
      gettext("Team"),
      gettext("Position"),
      gettext("Rushing attempts per game average"),
      gettext("Rushing attempts"),
      gettext("Total rushing yards"),
      gettext("Rushing average yards per attempt"),
      gettext("Rushing yards per game"),
      gettext("Total rushing touchdowns"),
      gettext("Rushing first downs"),
      gettext("Rushing first down percentage"),
      gettext("Rushing 20"),
      gettext("Rushing 40"),
      gettext("Rushing fumbles"),
      gettext("Longest rush")
    ]
  end

  defp to_csv(%Statistic{} = statistic) do
    [
      statistic.player,
      statistic.team,
      statistic.position,
      statistic.rushing_attempts_per_game_average,
      statistic.rushing_attempts,
      statistic.total_rushing_yards,
      statistic.rushing_average_yards_per_attempt,
      statistic.rushing_yards_per_game,
      statistic.total_rushing_touchdowns,
      statistic.rushing_first_downs,
      statistic.rushing_first_down_percentage,
      statistic.rushing_20,
      statistic.rushing_40,
      statistic.rushing_fumbles,
      format_longest_rush(statistic)
    ]
  end

  defp to_csv(headers), do: headers

  defp format_longest_rush(statistic) do
    if statistic.is_longest_rush_touchdown do
      "#{statistic.longest_rush}T"
    else
      statistic.longest_rush
    end
  end
end
