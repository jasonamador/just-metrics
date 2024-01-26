defmodule JustMetrics.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      JustMetricsWeb.Telemetry,
      JustMetrics.Repo,
      {DNSCluster, query: Application.get_env(:just_metrics, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: JustMetrics.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: JustMetrics.Finch},
      # Start a worker by calling: JustMetrics.Worker.start_link(arg)
      # {JustMetrics.Worker, arg},
      # Start to serve requests, typically the last entry
      JustMetricsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: JustMetrics.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    JustMetricsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
