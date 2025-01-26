defmodule MagicLink.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MagicLinkWeb.Telemetry,
      MagicLink.Repo,
      {DNSCluster, query: Application.get_env(:magic_link, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MagicLink.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: MagicLink.Finch},
      # Start a worker by calling: MagicLink.Worker.start_link(arg)
      # {MagicLink.Worker, arg},
      # Start to serve requests, typically the last entry
      MagicLinkWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MagicLink.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MagicLinkWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
