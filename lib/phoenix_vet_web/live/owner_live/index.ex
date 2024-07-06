defmodule PhoenixVetWeb.OwnerLive.Index do
  use PhoenixVetWeb, :live_view

  alias PhoenixVet.Practise

  def mount(_params, _session, socket) do
    {:ok, stream(socket, :owners, Practise.get_owners!())}
  end
end
