defmodule PhoenixVet.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhoenixVetWeb.Telemetry,
      PhoenixVet.Repo,
      {DNSCluster, query: Application.get_env(:phoenix_vet, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhoenixVet.PubSub},
      {AshAuthentication.Supervisor, otp_app: :phoenix_vet},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhoenixVet.Finch},
      # Start a worker by calling: PhoenixVet.Worker.start_link(arg)
      # {PhoenixVet.Worker, arg},
      # Start to serve requests, typically the last entry
      PhoenixVetWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixVet.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixVetWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
