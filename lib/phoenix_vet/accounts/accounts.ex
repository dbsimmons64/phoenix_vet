defmodule PhoenixVet.Accounts do
  use Ash.Domain

  resources do
    resource PhoenixVet.Accounts.User
    resource PhoenixVet.Accounts.Token
  end
end
