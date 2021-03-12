defmodule BooksWeb.ChatLiveView do
  use Phoenix.LiveView
  alias Books.Chats
  alias BooksWeb.Presence

  defp topic(chat_id), do: "chat:#{chat_id}"

  @impl true
  def mount(_params, %{"chat" => chat, "current_user" => current_user}, socket) do
    Presence.track_presence(
      self(),
      topic(chat.id),
      current_user.id,
      default_user_presence_payload(current_user)
    )

    BooksWeb.Endpoint.subscribe(topic(chat.id))

    {:ok,
     assign(socket,
       chat: chat,
       message: Chats.change_message(),
       current_user: current_user,
       users: Presence.list_presences(topic(chat.id)),
       username_colors: username_colors(chat)
     )}
  end

  @impl true
  def render(assigns) do
    BooksWeb.ChatView.render("show.html", assigns)
  end

  @impl true
  def handle_info(%{event: "presence_diff"}, socket = %{assigns: %{chat: chat}}) do
    {:noreply,
     assign(socket,
       users: Presence.list_presences(topic(chat.id))
     )}
  end

  def handle_info(%{event: "message", payload: state}, socket) do
    {:noreply, assign(socket, state)}
  end

  @impl true
  def handle_event("message", %{"message" => %{"content" => ""}}, socket) do
    IO.puts "Testing!!!!!!! no content!!"

    {:noreply, socket}
  end

  @impl true
  def handle_event("message", %{"message" => message_params}, socket) do
    IO.puts "Testing!!!!!!! MEAAAGHWGgherhbe!!"
    chat = Chats.create_message(message_params)
    BooksWeb.Endpoint.broadcast_from(self(), topic(chat.id), "message", %{chat: chat})
    {:noreply, assign(socket, chat: chat, message: Chats.change_message())}
  end

  def handle_event("typing", _value, socket = %{assigns: %{chat: chat, current_user: user}}) do
    Presence.update_presence(self(), topic(chat.id), user.id, %{typing: true})
    {:noreply, socket}
  end

  def handle_event(
        "stop_typing",
        value,
        socket = %{assigns: %{chat: chat, current_user: user, message: message}}
      ) do
    message = Chats.change_message(message, %{content: value})
    Presence.update_presence(self(), topic(chat.id), user.id, %{typing: false})
    {:noreply, assign(socket, message: message)}
  end

  defp default_user_presence_payload(user) do
    %{
      typing: false,
      email: user.email,
      user_id: user.id
    }
  end

  defp random_color do
    hex_code =
      ColorStream.hex()
      |> Enum.take(1)
      |> List.first()

    "##{hex_code}"
  end

  def username_colors(chat) do
    Enum.map(chat.messages, fn message -> message.user end)
    |> Enum.map(fn user -> user.email end)
    |> Enum.uniq()
    |> Enum.into(%{}, fn email -> {email, random_color()} end)
  end
end
