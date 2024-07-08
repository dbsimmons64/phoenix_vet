defmodule PhoenixVet.Practise.Owner do
  use Ash.Resource,
    domain: PhoenixVet.Practise,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "owners"
    repo PhoenixVet.Repo
  end

  attributes do
    integer_primary_key :id

    attribute :email, :string

    attribute :name, :string do
      allow_nil? false
    end

    attribute :phone, :string

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  actions do
    create :create do
      accept [:email, :name]
      argument :pets, {:array, :map}

      change manage_relationship(:pets, type: :create)
    end

    # Need a default read, without arguments, to support the update. Primary read actions should not have
    # any arguments.
    read :read do
      primary? true
    end

    read :read_by_id do
      argument :id, :integer, allow_nil?: false

      filter expr(id == ^arg(:id))
    end

    update :update do
      accept [:email, :name, :phone]

      argument :pets, {:array, :map}

      change manage_relationship(:pets, type: :direct_control)

      require_atomic? false
    end

    destroy :destroy do
      primary? true
    end
  end

  relationships do
    has_many :pets, PhoenixVet.Practise.Pet
  end
end
