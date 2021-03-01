defmodule Books.PagesTest do
  use Books.DataCase

  alias Books.Pages

  describe "pages" do
    alias Books.Pages.Page

    @valid_attrs %{passive_ability: 42, serial_number: 42, title: "some title", type: 42}
    @update_attrs %{passive_ability: 43, serial_number: 43, title: "some updated title", type: 43}
    @invalid_attrs %{passive_ability: nil, serial_number: nil, title: nil, type: nil}

    def page_fixture(attrs \\ %{}) do
      {:ok, page} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Pages.create_page()

      page
    end

    test "list_pages/0 returns all pages" do
      page = page_fixture()
      assert Pages.list_pages() == [page]
    end

    test "get_page!/1 returns the page with given id" do
      page = page_fixture()
      assert Pages.get_page!(page.id) == page
    end

    test "create_page/1 with valid data creates a page" do
      assert {:ok, %Page{} = page} = Pages.create_page(@valid_attrs)
      assert page.passive_ability == 42
      assert page.serial_number == 42
      assert page.title == "some title"
      assert page.type == 42
    end

    test "create_page/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pages.create_page(@invalid_attrs)
    end

    test "update_page/2 with valid data updates the page" do
      page = page_fixture()
      assert {:ok, %Page{} = page} = Pages.update_page(page, @update_attrs)
      assert page.passive_ability == 43
      assert page.serial_number == 43
      assert page.title == "some updated title"
      assert page.type == 43
    end

    test "update_page/2 with invalid data returns error changeset" do
      page = page_fixture()
      assert {:error, %Ecto.Changeset{}} = Pages.update_page(page, @invalid_attrs)
      assert page == Pages.get_page!(page.id)
    end

    test "delete_page/1 deletes the page" do
      page = page_fixture()
      assert {:ok, %Page{}} = Pages.delete_page(page)
      assert_raise Ecto.NoResultsError, fn -> Pages.get_page!(page.id) end
    end

    test "change_page/1 returns a page changeset" do
      page = page_fixture()
      assert %Ecto.Changeset{} = Pages.change_page(page)
    end
  end
end
