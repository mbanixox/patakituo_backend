defmodule PatakituoBackend.Counties do
  @moduledoc """
  The Counties context.
  """

  import Ecto.Query, warn: false
  alias PatakituoBackend.Repo

  alias PatakituoBackend.Counties.County

  @doc """
  Returns the list of counties.

  ## Examples

      iex> list_counties()
      [%County{}, ...]

  """
  def list_counties do
    Repo.all(County)
  end

  @doc """
  Gets a single county.

  Raises `Ecto.NoResultsError` if the County does not exist.

  ## Examples

      iex> get_county!(123)
      %County{}

      iex> get_county!(456)
      ** (Ecto.NoResultsError)

  """
  def get_county!(id), do: Repo.get!(County, id)

  @doc """
  Creates a county.

  ## Examples

      iex> create_county(%{field: value})
      {:ok, %County{}}

      iex> create_county(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_county(attrs) do
    %County{}
    |> County.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates multiple counties at once.

  ## Examples

      iex> bulk_create_counties([%{name: "Nairobi", code: 47}, ...])
      {:ok, [%County{}, ...]}

      iex> bulk_create_counties([%{name: "", code: 1}])
      {:error, %Ecto.Changeset{}}

  """
  def bulk_create_counties(attrs_list) when is_list(attrs_list) do
    Repo.transaction(fn ->
      Enum.map(attrs_list, fn attrs ->
        case create_county(attrs) do
          {:ok, county} -> county
          {:error, changeset} -> Repo.rollback(changeset)
        end
      end)
    end)
  end

  @doc """
  Updates a county.

  ## Examples

      iex> update_county(county, %{field: new_value})
      {:ok, %County{}}

      iex> update_county(county, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_county(%County{} = county, attrs) do
    county
    |> County.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a county.

  ## Examples

      iex> delete_county(county)
      {:ok, %County{}}

      iex> delete_county(county)
      {:error, %Ecto.Changeset{}}

  """
  def delete_county(%County{} = county) do
    Repo.delete(county)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking county changes.

  ## Examples

      iex> change_county(county)
      %Ecto.Changeset{data: %County{}}

  """
  def change_county(%County{} = county, attrs \\ %{}) do
    County.changeset(county, attrs)
  end
end
