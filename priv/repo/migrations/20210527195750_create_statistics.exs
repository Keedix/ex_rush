defmodule ExRush.Repo.Migrations.CreateStatistics do
  use Ecto.Migration

  def change do
    create table(:statistics) do
      add :player, :string
      add :team, :string
      add :position, :string
      add :rushing_attempts_per_game_average, :float
      add :rushing_attempts, :integer
      add :total_rushing_yards, :float
      add :rushing_average_yards_per_attempt, :float
      add :rushing_yards_per_game, :float
      add :total_rushing_touchdowns, :integer
      add :rushing_first_downs, :integer
      add :rushing_first_down_percentage, :float
      add :rushing_20, :integer
      add :rushing_40, :integer
      add :rushing_fumbles, :integer
      add :longest_rush, :integer
      add :is_longest_rush_touchdown, :boolean

      timestamps()
    end

    create index(
             "statistics",
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
             unique: true,
             name: "stat_index"
           )
  end
end
