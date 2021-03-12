defmodule BooksWeb.ChatLiveTest do
  use BooksWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Books.Chats

  @create_attrs %{room_name: "some room_name"}
  @update_attrs %{room_name: "some updated room_name"}
  @invalid_attrs %{room_name: nil}

  defp fixture(:chat) do
    {:ok, chat} = Chats.create_chat(@create_attrs)
    chat
  end

  defp create_chat(_) do
    chat = fixture(:chat)
    %{chat: chat}
  end

  describe "Index" do
    setup [:create_chat]

    test "lists all chats", %{conn: conn, chat: chat} do
      {:ok, _index_live, html} = live(conn, Routes.chat_index_path(conn, :index))

      assert html =~ "Listing Chats"
      assert html =~ chat.room_name
    end

    test "saves new chat", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.chat_index_path(conn, :index))

      assert index_live |> element("a", "New Chat") |> render_click() =~
               "New Chat"

      assert_patch(index_live, Routes.chat_index_path(conn, :new))

      assert index_live
             |> form("#chat-form", chat: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#chat-form", chat: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.chat_index_path(conn, :index))

      assert html =~ "Chat created successfully"
      assert html =~ "some room_name"
    end

    test "updates chat in listing", %{conn: conn, chat: chat} do
      {:ok, index_live, _html} = live(conn, Routes.chat_index_path(conn, :index))

      assert index_live |> element("#chat-#{chat.id} a", "Edit") |> render_click() =~
               "Edit Chat"

      assert_patch(index_live, Routes.chat_index_path(conn, :edit, chat))

      assert index_live
             |> form("#chat-form", chat: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#chat-form", chat: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.chat_index_path(conn, :index))

      assert html =~ "Chat updated successfully"
      assert html =~ "some updated room_name"
    end

    test "deletes chat in listing", %{conn: conn, chat: chat} do
      {:ok, index_live, _html} = live(conn, Routes.chat_index_path(conn, :index))

      assert index_live |> element("#chat-#{chat.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#chat-#{chat.id}")
    end
  end

  describe "Show" do
    setup [:create_chat]

    test "displays chat", %{conn: conn, chat: chat} do
      {:ok, _show_live, html} = live(conn, Routes.chat_show_path(conn, :show, chat))

      assert html =~ "Show Chat"
      assert html =~ chat.room_name
    end

    test "updates chat within modal", %{conn: conn, chat: chat} do
      {:ok, show_live, _html} = live(conn, Routes.chat_show_path(conn, :show, chat))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Chat"

      assert_patch(show_live, Routes.chat_show_path(conn, :edit, chat))

      assert show_live
             |> form("#chat-form", chat: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#chat-form", chat: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.chat_show_path(conn, :show, chat))

      assert html =~ "Chat updated successfully"
      assert html =~ "some updated room_name"
    end
  end
end
