# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
import Config

config :ex_rush, ExRush.Repo,
  # ssl: true,
  database: System.get_env("DB_NAME"),
  username: System.get_env("DB_USERNAME"),
  password: System.get_env("DB_PASSWORD"),
  hostname: System.get_env("DB_HOSTNAME"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

port = String.to_integer(System.get_env("PORT") || "4000")

config :ex_rush, ExRushWeb.Endpoint,
  http: [
    port: port,
    transport_options: [socket_opts: [:inet6]]
  ],
  url: [host: System.get_env("HOST"), port: port],
  secret_key_base: secret_key_base,
  check_origin: ["http://localhost:4000"],
  server: true

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
#     config :ex_rush, ExRushWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
