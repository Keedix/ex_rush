defmodule ExRush.StatisticsTest do
  use ExRush.DataCase

  alias ExRush.Statistics

  describe "statistics" do
    alias ExRush.Statistics.Statistic

    @valid_attrs %{
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

    def statistic_fixture(attrs \\ %{}) do
      {:ok, statistic} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Statistics.create_statistic()

      statistic
    end

    test "list_statistics/0 returns all statistics" do
      statistic = statistic_fixture()
      assert Statistics.list_statistics() == [statistic]
    end

    test "get_statistic!/1 returns the statistic with given id" do
      statistic = statistic_fixture()
      assert Statistics.get_statistic!(statistic.id) == statistic
    end

    test "create_statistic/1 with valid data creates a statistic" do
      assert {:ok, %Statistic{} = statistic} = Statistics.create_statistic(@valid_attrs)
      assert statistic.player == "some player"
      assert statistic.position == "some position"
      assert statistic.rushing_20 == 42
      assert statistic.rushing_40 == 42
      assert statistic.rushing_attempts == 42
      assert statistic.rushing_attempts_per_game_average == 120.5
      assert statistic.rushing_average_yards_per_attempt == 120.5
      assert statistic.rushing_first_down_percentage == 120.5
      assert statistic.rushing_first_downs == 42
      assert statistic.rushing_fumbles == 42
      assert statistic.rushing_yards_per_game == 120.5
      assert statistic.team == "some team"
      assert statistic.total_rushing_touchdowns == 42
      assert statistic.total_rushing_yards == 42
    end

    test "create_statistic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Statistics.create_statistic(@invalid_attrs)
    end

    test "update_statistic/2 with valid data updates the statistic" do
      statistic = statistic_fixture()

      assert {:ok, %Statistic{} = statistic} =
               Statistics.update_statistic(statistic, @update_attrs)

      assert statistic.player == "some updated player"
      assert statistic.position == "some updated position"
      assert statistic.rushing_20 == 43
      assert statistic.rushing_40 == 43
      assert statistic.rushing_attempts == 43
      assert statistic.rushing_attempts_per_game_average == 456.7
      assert statistic.rushing_average_yards_per_attempt == 456.7
      assert statistic.rushing_first_down_percentage == 456.7
      assert statistic.rushing_first_downs == 43
      assert statistic.rushing_fumbles == 43
      assert statistic.rushing_yards_per_game == 456.7
      assert statistic.team == "some updated team"
      assert statistic.total_rushing_touchdowns == 43
      assert statistic.total_rushing_yards == 43
    end

    test "update_statistic/2 with invalid data returns error changeset" do
      statistic = statistic_fixture()
      assert {:error, %Ecto.Changeset{}} = Statistics.update_statistic(statistic, @invalid_attrs)
      assert statistic == Statistics.get_statistic!(statistic.id)
    end

    test "delete_statistic/1 deletes the statistic" do
      statistic = statistic_fixture()
      assert {:ok, %Statistic{}} = Statistics.delete_statistic(statistic)
      assert_raise Ecto.NoResultsError, fn -> Statistics.get_statistic!(statistic.id) end
    end

    test "change_statistic/1 returns a statistic changeset" do
      statistic = statistic_fixture()
      assert %Ecto.Changeset{} = Statistics.change_statistic(statistic)
    end
  end
end
