defmodule Books.PassiveAbilities do
  @moduledoc """
  The PassiveAbilities context.
  """

  import Ecto.Query, warn: false
  alias Books.Repo

  alias Books.PassiveAbilities.PassiveAbility

  @doc """
  Returns the list of passive_abilities.

  ## Examples

      iex> list_passive_abilities()
      [%PassiveAbility{}, ...]

  """
  def list_passive_abilities do
    Repo.all(PassiveAbility)
  end

  @doc """
  Gets a single passive_ability.

  Raises `Ecto.NoResultsError` if the Passive ability does not exist.

  ## Examples

      iex> get_passive_ability!(123)
      %PassiveAbility{}

      iex> get_passive_ability!(456)
      ** (Ecto.NoResultsError)

  """
  def get_passive_ability!(id), do: Repo.get!(PassiveAbility, id)

  @doc """
  Creates a passive_ability.

  ## Examples

      iex> create_passive_ability(%{field: value})
      {:ok, %PassiveAbility{}}

      iex> create_passive_ability(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_passive_ability(attrs \\ %{}) do
    %PassiveAbility{}
    |> PassiveAbility.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a passive_ability.

  ## Examples

      iex> update_passive_ability(passive_ability, %{field: new_value})
      {:ok, %PassiveAbility{}}

      iex> update_passive_ability(passive_ability, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_passive_ability(%PassiveAbility{} = passive_ability, attrs) do
    passive_ability
    |> PassiveAbility.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a passive_ability.

  ## Examples

      iex> delete_passive_ability(passive_ability)
      {:ok, %PassiveAbility{}}

      iex> delete_passive_ability(passive_ability)
      {:error, %Ecto.Changeset{}}

  """
  def delete_passive_ability(%PassiveAbility{} = passive_ability) do
    Repo.delete(passive_ability)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking passive_ability changes.

  ## Examples

      iex> change_passive_ability(passive_ability)
      %Ecto.Changeset{data: %PassiveAbility{}}

  """
  def change_passive_ability(%PassiveAbility{} = passive_ability, attrs \\ %{}) do
    PassiveAbility.changeset(passive_ability, attrs)
  end
end
