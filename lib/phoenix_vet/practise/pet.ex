defmodule PhoenixVet.Practise.Pet do
  use Ash.Resource,
    domain: PhoenixVet.Practise,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "pets"
    repo PhoenixVet.Repo
  end

  attributes do
    integer_primary_key :id

    attribute :date_of_birth, :date
    attribute :name, :string

    attribute :type, :atom do
      constraints one_of: [:dog, :cat, :hamster]
    end

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  actions do
    create :create do
      accept [:name]
      primary? true
    end

    read :read do
      primary? true
    end

    update :update do
      accept [:name]
      validate string_length(:name, min: 3)
      primary? true
      require_atomic? false
    end

    update :assign do
      accept [:owner_id]
    end

    destroy :destroy do
      primary? true
    end
  end

  relationships do
    belongs_to :owner, PhoenixVet.Practise.Owner do
      attribute_type :integer
      allow_nil? false
    end
  end
end
