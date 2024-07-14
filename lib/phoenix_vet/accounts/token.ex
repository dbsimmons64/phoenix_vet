defmodule PhoenixVet.Accounts.Token do
  use Ash.Resource,
    domain: PhoenixVet.Accounts,
    data_layer: AshPostgres.DataLayer,
    # authorizers: [Ash.Policy.Authorizer],
    extensions: [AshAuthentication.TokenResource]

  postgres do
    table "tokens"
    repo PhoenixVet.Repo
  end

  # If using policies add the following bypass:
  # policies do
  #   bypass AshAuthentication.Checks.AshAuthenticationInteraction do
  #     authorize_if always()
  #   end
  # end
end
