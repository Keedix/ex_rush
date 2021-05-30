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
    total_rushing_yards: 42
  }
  @update_attrs %{
    player: "some updated player",
    position: "some updated position",
    rushing_20: 43,
    rushing_40: 43,
    rushing_attempts: 43,
    rushing_attempts_per_game_average: 456.7,
    rushing_average_yards_per_attempt: 456.7,
    rushing_first_down_percentage: 456.7,
    rushing_first_downs: 43,
    rushing_fumbles: 43,
    rushing_yards_per_game: 456.7,
    team: "some updated team",
    total_rushing_touchdowns: 43,
    total_rushing_yards: 43
  }
  @invalid_attrs %{
    player: nil,
    position: nil,
    rushing_20: nil,
    rushing_40: nil,
    rushing_attempts: nil,
    rushing_attempts_per_game_average: nil,
    rushing_average_yards_per_attempt: nil,
    rushing_first_down_percentage: nil,
    rushing_first_downs: nil,
    rushing_fumbles: nil,
    rushing_yards_per_game: nil,
    team: nil,
    total_rushing_touchdowns: nil,
    total_rushing_yards: nil
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
      {:ok, _index_live, html} = live(conn, Routes.statistic_index_path(conn, :index))

      assert html =~ "Listing Statistics"
      assert html =~ statistic.player
    end

    test "saves new statistic", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.statistic_index_path(conn, :index))

      assert index_live |> element("a", "New Statistic") |> render_click() =~
               "New Statistic"

      assert_patch(index_live, Routes.statistic_index_path(conn, :new))

      assert index_live
             |> form("#statistic-form", statistic: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#statistic-form", statistic: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.statistic_index_path(conn, :index))

      assert html =~ "Statistic created successfully"
      assert html =~ "some player"
    end

    test "updates statistic in listing", %{conn: conn, statistic: statistic} do
      {:ok, index_live, _html} = live(conn, Routes.statistic_index_path(conn, :index))

      assert index_live |> element("#statistic-#{statistic.id} a", "Edit") |> render_click() =~
               "Edit Statistic"

      assert_patch(index_live, Routes.statistic_index_path(conn, :edit, statistic))

      assert index_live
             |> form("#statistic-form", statistic: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#statistic-form", statistic: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.statistic_index_path(conn, :index))

      assert html =~ "Statistic updated successfully"
      assert html =~ "some updated player"
    end

    test "deletes statistic in listing", %{conn: conn, statistic: statistic} do
      {:ok, index_live, _html} = live(conn, Routes.statistic_index_path(conn, :index))

      assert index_live |> element("#statistic-#{statistic.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#statistic-#{statistic.id}")
    end
  end

  describe "Show" do
    setup [:create_statistic]

    test "displays statistic", %{conn: conn, statistic: statistic} do
      {:ok, _show_live, html} = live(conn, Routes.statistic_show_path(conn, :show, statistic))

      assert html =~ "Show Statistic"
      assert html =~ statistic.player
    end

    test "updates statistic within modal", %{conn: conn, statistic: statistic} do
      {:ok, show_live, _html} = live(conn, Routes.statistic_show_path(conn, :show, statistic))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Statistic"

      assert_patch(show_live, Routes.statistic_show_path(conn, :edit, statistic))

      assert show_live
             |> form("#statistic-form", statistic: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#statistic-form", statistic: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.statistic_show_path(conn, :show, statistic))

      assert html =~ "Statistic updated successfully"
      assert html =~ "some updated player"
    end
  end
end
