defmodule ExRush.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  @mix_env Mix.env()

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ExRush.Repo,
      # Start the Telemetry supervisor
      ExRushWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ExRush.PubSub},
      # Start the Endpoint (http/https)
      ExRushWeb.Endpoint,
      {Cachex, name: ExRush.Statistics}
      # Start a worker by calling: ExRush.Worker.start_link(arg)
      # {ExRush.Worker, arg}
    ]

    children =
      if @mix_env != :test do
        children ++ [{ExRush.Ingestor, "/priv/data/rushing.json"}]
      else
        children
      end

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExRush.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ExRushWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
