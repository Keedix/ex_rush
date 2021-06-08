defmodule ExRushWeb.StatisticLiveTest do
  use ExRushWeb.ConnCase

  import Phoenix.LiveViewTest

  alias ExRush.Statistics

  @create_attrs %{
    player: "some player",
    position: "some position",
    rushing_20: 42,
    rushing_40: 42,
    rushing_attempts: 42,
    rushing_attempts_per_game_average: 120.5,
    rushing_average_yards_per_attempt: 120.5,
    rushing_first_down_percentage: 120.5,
    rushing_first_downs: 42,
    rushing_fumbles: 42,
    rushing_yards_per_game: 120.5,
    team: "some team",
    total_rushing_touchdowns: 42,
    total_rushing_yards: 42,
    longest_rush_with_touchdown: "75T"
  }

  defp fixture(:statistic) do
    {:ok, statistic} = Statistics.create_statistic(@create_attrs)
    statistic
  end

  defp create_statistic(_) do
    statistic = fixture(:statistic)
    %{statistic: statistic}
  end

  describe "Index" do
    setup [:create_statistic]

    test "lists all statistics", %{conn: conn, statistic: statistic} do
      {:ok, _index_live, html} = live(conn, Routes.live_path(conn, ExRushWeb.StatisticLive.Index))

      assert html =~ "Player"
      assert html =~ "Position"
      assert html =~ "Rushing attempts per game average"
      assert html =~ "Rushing attempts"
      assert html =~ "Rushing average yards per attempt"
      assert html =~ "Rushing yards per game"
      assert html =~ "Total rushing touchdowns"
      assert html =~ "Rushing first downs"
      assert html =~ "Rushing first down percentage"
      assert html =~ "Rushing 20"
      assert html =~ "Rushing 40"
      assert html =~ "Rushing fumbles"
      assert html =~ "Longest rush"
      assert html =~ statistic.player
    end
  end
end
