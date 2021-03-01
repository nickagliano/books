defmodule BooksWeb.PassiveAbilityLive.FormComponent do
  use BooksWeb, :live_component

  alias Books.PassiveAbilities

  @impl true
  def update(%{passive_ability: passive_ability} = assigns, socket) do
    changeset = PassiveAbilities.change_passive_ability(passive_ability)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"passive_ability" => passive_ability_params}, socket) do
    changeset =
      socket.assigns.passive_ability
      |> PassiveAbilities.change_passive_ability(passive_ability_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"passive_ability" => passive_ability_params}, socket) do
    save_passive_ability(socket, socket.assigns.action, passive_ability_params)
  end

  defp save_passive_ability(socket, :edit, passive_ability_params) do
    case PassiveAbilities.update_passive_ability(socket.assigns.passive_ability, passive_ability_params) do
      {:ok, _passive_ability} ->
        {:noreply,
         socket
         |> put_flash(:info, "Passive ability updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_passive_ability(socket, :new, passive_ability_params) do
    case PassiveAbilities.create_passive_ability(passive_ability_params) do
      {:ok, _passive_ability} ->
        {:noreply,
         socket
         |> put_flash(:info, "Passive ability created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
