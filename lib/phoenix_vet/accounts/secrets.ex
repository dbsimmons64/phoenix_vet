defmodule PhoenixVet.Accounts.Secrets do
  use AshAuthentication.Secret

  def secret_for([:authentication, :tokens, :signing_secret], PhoenixVet.Accounts.User, _) do
    case Application.fetch_env(:phoenix_vet, PhoenixVetWeb.Endpoint) |> dbg() do
      {:ok, endpoint_config} ->
        Keyword.fetch(endpoint_config, :secret_key_base)

      :error ->
        :error
    end
  end
end
