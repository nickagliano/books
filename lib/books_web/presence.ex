defmodule BooksWeb.Presence do
  use Phoenix.Presence,
    otp_app: :books,
    pubsub_server: Books.PubSub

  alias BooksWeb.Presence

  def track_presence(pid, topic, key, payload) do
    Presence.track(pid, topic, key, payload)
  end

  def update_presence(pid, topic, key, payload) do
    metas =
      Presence.get_by_key(topic, key)[:metas]
      |> List.first()
      |> Map.merge(payload)

    Presence.update(pid, topic, key, metas)
  end

  def list_presences(topic) do
    Presence.list(topic)
    |> Enum.map(fn {_user_id, data} ->
      data[:metas]
      |> List.first()
    end)
  end
end
