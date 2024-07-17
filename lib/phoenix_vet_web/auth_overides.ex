defmodule PhoenixVetWeb.AuthOverides do
  use AshAuthentication.Phoenix.Overrides
  alias AshAuthentication.Phoenix.Components

  override Components.Banner do
    set :image_url, "/images/vet1.svg"
    set :image_class, "w-96"
  end
end
