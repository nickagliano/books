defmodule Books.Repo.Migrations.CreatePassiveAbilities do
  use Ecto.Migration

  def change do
    create table(:passive_abilities) do
      add :name, :string
      add :description, :string

      timestamps()
    end

  end
end
