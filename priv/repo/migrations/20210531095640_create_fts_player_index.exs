defmodule ExRush.Repo.Migrations.CreateFtsPlayerIndex do
  use Ecto.Migration


  def change do
    execute "CREATE EXTENSION pg_trgm;"
    execute "CREATE INDEX player_fts_idx ON statistics USING gin (to_tsvector('english', player));"
  end
end
