defmodule PhoenixVet.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_vet,
    adapter: Ecto.Adapters.Postgres
end
