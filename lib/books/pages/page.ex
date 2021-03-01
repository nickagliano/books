defmodule Books.Pages.Page do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pages" do
    field :passive_ability, :integer
    field :serial_number, :integer
    field :title, :string
    field :type, :integer

    timestamps()
  end

  @doc false
  def changeset(page, attrs) do
    page
    |> cast(attrs, [:title, :type, :passive_ability, :serial_number])
    |> validate_required([:title, :type, :passive_ability, :serial_number])
  end
end
