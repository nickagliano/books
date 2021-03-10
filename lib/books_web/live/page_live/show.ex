defmodule BooksWeb.PageLive.Show do
  @moduledoc """
  Show action for Pages (not like web pages, but those which go in books!)
  """
  use BooksWeb, :live_view

  alias Books.Pages

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:page, Pages.get_page!(id))}
  end

  defp page_title(:show), do: "Show Page"
  defp page_title(:edit), do: "Edit Page"
end
