defmodule BooksWeb.PageLiveTest do
  use BooksWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Books.Pages

  @create_attrs %{passive_ability: 42, serial_number: 42, title: "some title", type: 42}
  @update_attrs %{passive_ability: 43, serial_number: 43, title: "some updated title", type: 43}
  @invalid_attrs %{passive_ability: nil, serial_number: nil, title: nil, type: nil}

  defp fixture(:page) do
    {:ok, page} = Pages.create_page(@create_attrs)
    page
  end

  defp create_page(_) do
    page = fixture(:page)
    %{page: page}
  end

  describe "Index" do
    setup [:create_page]

    test "lists all pages", %{conn: conn, page: page} do
      {:ok, _index_live, html} = live(conn, Routes.page_index_path(conn, :index))

      assert html =~ "Listing Pages"
      assert html =~ page.title
    end

    test "saves new page", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.page_index_path(conn, :index))

      assert index_live |> element("a", "New Page") |> render_click() =~
               "New Page"

      assert_patch(index_live, Routes.page_index_path(conn, :new))

      assert index_live
             |> form("#page-form", page: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#page-form", page: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.page_index_path(conn, :index))

      assert html =~ "Page created successfully"
      assert html =~ "some title"
    end

    test "updates page in listing", %{conn: conn, page: page} do
      {:ok, index_live, _html} = live(conn, Routes.page_index_path(conn, :index))

      assert index_live |> element("#page-#{page.id} a", "Edit") |> render_click() =~
               "Edit Page"

      assert_patch(index_live, Routes.page_index_path(conn, :edit, page))

      assert index_live
             |> form("#page-form", page: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#page-form", page: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.page_index_path(conn, :index))

      assert html =~ "Page updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes page in listing", %{conn: conn, page: page} do
      {:ok, index_live, _html} = live(conn, Routes.page_index_path(conn, :index))

      assert index_live |> element("#page-#{page.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#page-#{page.id}")
    end
  end

  describe "Show" do
    setup [:create_page]

    test "displays page", %{conn: conn, page: page} do
      {:ok, _show_live, html} = live(conn, Routes.page_show_path(conn, :show, page))

      assert html =~ "Show Page"
      assert html =~ page.title
    end

    test "updates page within modal", %{conn: conn, page: page} do
      {:ok, show_live, _html} = live(conn, Routes.page_show_path(conn, :show, page))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Page"

      assert_patch(show_live, Routes.page_show_path(conn, :edit, page))

      assert show_live
             |> form("#page-form", page: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#page-form", page: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.page_show_path(conn, :show, page))

      assert html =~ "Page updated successfully"
      assert html =~ "some updated title"
    end
  end
end
