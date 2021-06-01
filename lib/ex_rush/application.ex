defmodule ExRush.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @path Application.fetch_env!(:ex_rush, :ingestor_path)

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
      {Cachex, name: ExRush.Statistics},
      {ExRush.Ingestor, @path}
      # Start a worker by calling: ExRush.Worker.start_link(arg)
      # {ExRush.Worker, arg}
    ]

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
