defmodule Books.Repo.Migrations.CreatePages do
  use Ecto.Migration

  def change do
    create table(:pages) do
      add :title, :string
      add :type, :integer
      add :passive_ability, :integer
      add :serial_number, :integer

      timestamps()
    end

  end
end
