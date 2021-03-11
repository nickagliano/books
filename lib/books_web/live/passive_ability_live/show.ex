defmodule BooksWeb.PassiveAbilityLive.Show do
  @moduledoc """
  Show passive ability
  """
  use BooksWeb, :live_view

  alias Books.PassiveAbilities

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:passive_ability, PassiveAbilities.get_passive_ability!(id))}
  end

  defp page_title(:show), do: "Show Passive ability"
  defp page_title(:edit), do: "Edit Passive ability"
end
