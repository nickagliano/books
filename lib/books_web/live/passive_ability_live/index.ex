defmodule BooksWeb.PassiveAbilityLive.Index do
  @moduledoc """
  Index for PassiveAbilities
  """
  use BooksWeb, :live_view

  alias Books.PassiveAbilities
  alias Books.PassiveAbilities.PassiveAbility

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :passive_abilities, list_passive_abilities())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Passive ability")
    |> assign(:passive_ability, PassiveAbilities.get_passive_ability!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Passive ability")
    |> assign(:passive_ability, %PassiveAbility{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Passive abilities")
    |> assign(:passive_ability, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    passive_ability = PassiveAbilities.get_passive_ability!(id)
    {:ok, _} = PassiveAbilities.delete_passive_ability(passive_ability)

    {:noreply, assign(socket, :passive_abilities, list_passive_abilities())}
  end

  defp list_passive_abilities do
    PassiveAbilities.list_passive_abilities()
  end
end
