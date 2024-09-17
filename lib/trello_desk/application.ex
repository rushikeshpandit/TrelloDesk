defmodule TrelloDesk.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TrelloDeskWeb.Telemetry,
      TrelloDesk.Repo,
      {DNSCluster, query: Application.get_env(:trello_desk, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TrelloDesk.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: TrelloDesk.Finch},
      # Start a worker by calling: TrelloDesk.Worker.start_link(arg)
      # {TrelloDesk.Worker, arg},
      # Start to serve requests, typically the last entry
      TrelloDeskWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TrelloDesk.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TrelloDeskWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
