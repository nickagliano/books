defmodule Books.PassiveAbilities.PassiveAbility do
  use Ecto.Schema
  import Ecto.Changeset

  schema "passive_abilities" do
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(passive_ability, attrs) do
    passive_ability
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
