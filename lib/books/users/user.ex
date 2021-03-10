defmodule Books.Users.User do
  @moduledoc """
  user model
  """
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "users" do
    pow_user_fields()

    timestamps()
  end
end
