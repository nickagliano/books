defmodule BooksWeb.PassiveAbilityLiveTest do
  use BooksWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Books.PassiveAbilities

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  defp fixture(:passive_ability) do
    {:ok, passive_ability} = PassiveAbilities.create_passive_ability(@create_attrs)
    passive_ability
  end

  defp create_passive_ability(_) do
    passive_ability = fixture(:passive_ability)
    %{passive_ability: passive_ability}
  end

  describe "Index" do
    setup [:create_passive_ability]

    test "lists all passive_abilities", %{conn: conn, passive_ability: passive_ability} do
      {:ok, _index_live, html} = live(conn, Routes.passive_ability_index_path(conn, :index))

      assert html =~ "Listing Passive abilities"
      assert html =~ passive_ability.description
    end

    test "saves new passive_ability", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.passive_ability_index_path(conn, :index))

      assert index_live |> element("a", "New Passive ability") |> render_click() =~
               "New Passive ability"

      assert_patch(index_live, Routes.passive_ability_index_path(conn, :new))

      assert index_live
             |> form("#passive_ability-form", passive_ability: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#passive_ability-form", passive_ability: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.passive_ability_index_path(conn, :index))

      assert html =~ "Passive ability created successfully"
      assert html =~ "some description"
    end

    test "updates passive_ability in listing", %{conn: conn, passive_ability: passive_ability} do
      {:ok, index_live, _html} = live(conn, Routes.passive_ability_index_path(conn, :index))

      assert index_live |> element("#passive_ability-#{passive_ability.id} a", "Edit") |> render_click() =~
               "Edit Passive ability"

      assert_patch(index_live, Routes.passive_ability_index_path(conn, :edit, passive_ability))

      assert index_live
             |> form("#passive_ability-form", passive_ability: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#passive_ability-form", passive_ability: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.passive_ability_index_path(conn, :index))

      assert html =~ "Passive ability updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes passive_ability in listing", %{conn: conn, passive_ability: passive_ability} do
      {:ok, index_live, _html} = live(conn, Routes.passive_ability_index_path(conn, :index))

      assert index_live |> element("#passive_ability-#{passive_ability.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#passive_ability-#{passive_ability.id}")
    end
  end

  describe "Show" do
    setup [:create_passive_ability]

    test "displays passive_ability", %{conn: conn, passive_ability: passive_ability} do
      {:ok, _show_live, html} = live(conn, Routes.passive_ability_show_path(conn, :show, passive_ability))

      assert html =~ "Show Passive ability"
      assert html =~ passive_ability.description
    end

    test "updates passive_ability within modal", %{conn: conn, passive_ability: passive_ability} do
      {:ok, show_live, _html} = live(conn, Routes.passive_ability_show_path(conn, :show, passive_ability))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Passive ability"

      assert_patch(show_live, Routes.passive_ability_show_path(conn, :edit, passive_ability))

      assert show_live
             |> form("#passive_ability-form", passive_ability: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#passive_ability-form", passive_ability: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.passive_ability_show_path(conn, :show, passive_ability))

      assert html =~ "Passive ability updated successfully"
      assert html =~ "some updated description"
    end
  end
end
