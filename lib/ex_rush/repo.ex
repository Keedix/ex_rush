defmodule ExRush.Repo do
  use Ecto.Repo,
    otp_app: :ex_rush,
    adapter: Ecto.Adapters.Postgres
end
