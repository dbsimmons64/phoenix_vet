defmodule PhoenixVetWeb.OwnerLive do
  use PhoenixVetWeb, :live_view

  alias PhoenixVet.Practise
  alias PhoenixVet.Practise.Owner

  def mount(_params, _session, socket) do
    {:ok, stream(socket, :owners, Practise.get_owners!())}
  end

  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Owners")
    |> assign(:owners, Practise.get_owners!())
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Owner")
    |> assign(:submit_action, :save)
    |> assign(form: AshPhoenix.Form.for_create(Owner, :create) |> to_form())
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    case PhoenixVet.Practise.get_owner_by_id(id, load: :pets) do
      {:ok, [owner]} ->
        socket
        |> assign(:page_title, "Edit Owner")
        |> assign(:submit_action, :save)
        |> assign(
          form:
            AshPhoenix.Form.for_update(owner, :update,
              forms: [
                auto?: true
              ]
            )
        )

      _ ->
        redirect(socket, to: ~p"/owners")
    end
  end

  def handle_event("save", %{"form" => params}, socket) do
    case AshPhoenix.Form.submit(socket.assigns.form, params: params) do
      {:ok, _result} ->
        {:noreply, redirect(socket, to: "/owners")}

      {:error, form} ->
        {:noreply, assign(socket, form: form)}
    end
  end

  def handle_event("delete", %{"id" => id}, socket) do
    PhoenixVet.Practise.delete_owner(id)

    {:noreply, redirect(socket, to: ~p"/owners")}
  end

  def handle_event("add_pet", _params, socket) do
    form = AshPhoenix.Form.add_form(socket.assigns.form, "form[pets]", params: %{name: "wibble"})
    {:reply, %{tag_added: true}, assign(socket, form: form)}
  end

  def handle_event("delete_pet", %{"path" => path}, socket) do
    form = AshPhoenix.Form.remove_form(socket.assigns.form, path)

    {:reply, %{}, assign(socket, form: form)}
  end
end
