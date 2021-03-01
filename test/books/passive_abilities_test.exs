defmodule Books.PassiveAbilitiesTest do
  use Books.DataCase

  alias Books.PassiveAbilities

  describe "passive_abilities" do
    alias Books.PassiveAbilities.PassiveAbility

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def passive_ability_fixture(attrs \\ %{}) do
      {:ok, passive_ability} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PassiveAbilities.create_passive_ability()

      passive_ability
    end

    test "list_passive_abilities/0 returns all passive_abilities" do
      passive_ability = passive_ability_fixture()
      assert PassiveAbilities.list_passive_abilities() == [passive_ability]
    end

    test "get_passive_ability!/1 returns the passive_ability with given id" do
      passive_ability = passive_ability_fixture()
      assert PassiveAbilities.get_passive_ability!(passive_ability.id) == passive_ability
    end

    test "create_passive_ability/1 with valid data creates a passive_ability" do
      assert {:ok, %PassiveAbility{} = passive_ability} = PassiveAbilities.create_passive_ability(@valid_attrs)
      assert passive_ability.description == "some description"
      assert passive_ability.name == "some name"
    end

    test "create_passive_ability/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PassiveAbilities.create_passive_ability(@invalid_attrs)
    end

    test "update_passive_ability/2 with valid data updates the passive_ability" do
      passive_ability = passive_ability_fixture()
      assert {:ok, %PassiveAbility{} = passive_ability} = PassiveAbilities.update_passive_ability(passive_ability, @update_attrs)
      assert passive_ability.description == "some updated description"
      assert passive_ability.name == "some updated name"
    end

    test "update_passive_ability/2 with invalid data returns error changeset" do
      passive_ability = passive_ability_fixture()
      assert {:error, %Ecto.Changeset{}} = PassiveAbilities.update_passive_ability(passive_ability, @invalid_attrs)
      assert passive_ability == PassiveAbilities.get_passive_ability!(passive_ability.id)
    end

    test "delete_passive_ability/1 deletes the passive_ability" do
      passive_ability = passive_ability_fixture()
      assert {:ok, %PassiveAbility{}} = PassiveAbilities.delete_passive_ability(passive_ability)
      assert_raise Ecto.NoResultsError, fn -> PassiveAbilities.get_passive_ability!(passive_ability.id) end
    end

    test "change_passive_ability/1 returns a passive_ability changeset" do
      passive_ability = passive_ability_fixture()
      assert %Ecto.Changeset{} = PassiveAbilities.change_passive_ability(passive_ability)
    end
  end
end
