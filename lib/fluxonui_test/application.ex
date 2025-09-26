defmodule FluxonUITest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FluxonUITestWeb.Telemetry,
      FluxonUITest.Repo,
      {DNSCluster, query: Application.get_env(:fluxonui_test, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: FluxonUITest.PubSub},
      # Start a worker by calling: FluxonUITest.Worker.start_link(arg)
      # {FluxonUITest.Worker, arg},
      # Start to serve requests, typically the last entry
      FluxonUITestWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FluxonUITest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FluxonUITestWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
