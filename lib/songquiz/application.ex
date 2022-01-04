defmodule Songquiz.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SongquizWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Songquiz.PubSub},
      # Start the Endpoint (http/https)
      SongquizWeb.Endpoint,

      # Start a worker by calling: Songquiz.Worker.start_link(arg)
      # {Songquiz.Worker, arg}
      {Songquiz.RoomChannel.Monitor, [%{}]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Songquiz.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SongquizWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
