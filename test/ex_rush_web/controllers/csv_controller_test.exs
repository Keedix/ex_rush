defmodule ExRushWeb.CsvControllerTest do
  use ExRushWeb.ConnCase

  alias ExRush.Statistics
  alias ExRush.Statistics.Statistic

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
    longest_rush_with_touchdown: "72"
  }

  def fixture(:statistic) do
    {:ok, statistic} = Statistics.create_statistic(@create_attrs)
    statistic
  end

  describe "download" do
    setup :create_statistic

    test "downloads list of statistics", %{conn: conn} do
      conn = post(conn, Routes.csv_path(conn, :download))
      assert response(conn, 200)
      assert get_resp_header(conn, "content-type") == ["text/csv; charset=utf-8"]

      assert conn.resp_body ==
               "Player,Team,Position,Rushing attempts per game average,Rushing attempts,Total rushing yards,Rushing average yards per attempt,Rushing yards per game,Total rushing touchdowns,Rushing first downs,Rushing first down percentage,Rushing 20,Rushing 40,Rushing fumbles,Longest rush\r\nsome player,some team,some position,120.5,42,42.0,120.5,120.5,42,42,120.5,42,42,42,72\r\n"
    end
  end

  defp create_statistic(_) do
    statistic = fixture(:statistic)
    %{statistic: statistic}
  end
end
