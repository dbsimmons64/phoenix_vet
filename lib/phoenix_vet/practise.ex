defmodule PhoenixVet.Practise do
  use Ash.Domain

  resources do
    resource PhoenixVet.Practise.Owner do
      define :create_owner, action: :create, args: [:name, :email]
      define :get_owner_by_id, action: :read_by_id, args: [:id]
      define :update_owner, action: :update, args: [:id]
    end

    resource PhoenixVet.Practise.Pet do
      define :create_pet, action: :create
    end
  end
end
