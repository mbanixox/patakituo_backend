defmodule PatakituoBackend.Constituencies do
  @moduledoc """
  The Constituencies context.
  """

  import Ecto.Query, warn: false
  alias PatakituoBackend.Repo
  alias PatakituoBackend.Counties.County
  alias PatakituoBackend.Constituencies.Constituency

  @doc """
  Returns the list of constituencies.

  ## Examples

      iex> list_constituencies()
      [%Constituency{}, ...]

  """
  def list_constituencies do
    Repo.all(Constituency)
  end

  @doc """
  Gets a single constituency.

  Raises `Ecto.NoResultsError` if the Constituency does not exist.

  ## Examples

      iex> get_constituency!(123)
      %Constituency{}

      iex> get_constituency!(456)
      ** (Ecto.NoResultsError)

  """
  def get_constituency!(id), do: Repo.get!(Constituency, id)

  @doc """
  Creates a constituency.

  ## Examples

      iex> create_constituency(%{field: value})
      {:ok, %Constituency{}}

      iex> create_constituency(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_constituency(attrs) do
    %Constituency{}
    |> Constituency.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates multiple constituencies for a given county.

  ## Examples

      iex> bulk_create_constituencies("001", [%{iebc_code: 1, name: "Constituency 1"}, %{iebc_code: 2, name: "Constituency 2"}])
      {:ok, [%Constituency{}, %Constituency{}]}

      iex> bulk_create_constituencies("001", [%{iebc_code: nil, name: "Invalid Constituency"}])
      {:error, %Ecto.Changeset{}}

  """
  def bulk_create_constituencies(county_code, attrs_list) when is_list(attrs_list) do
    case Repo.get_by(County, code: county_code) do
      nil ->
        {:error, "County with code #{county_code} not found"}

      %County{id: county_id} ->
        Repo.transaction(fn ->
          Enum.map(attrs_list, fn attrs ->
            attrs_with_county = Map.put(attrs, :county_id, county_id)

            case create_constituency(attrs_with_county) do
              {:ok, constituency} -> constituency
              {:error, changeset} -> Repo.rollback(changeset)
            end
          end)
        end)
    end
  end

  @doc """
  Updates a constituency.

  ## Examples

      iex> update_constituency(constituency, %{field: new_value})
      {:ok, %Constituency{}}

      iex> update_constituency(constituency, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_constituency(%Constituency{} = constituency, attrs) do
    constituency
    |> Constituency.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a constituency.

  ## Examples

      iex> delete_constituency(constituency)
      {:ok, %Constituency{}}

      iex> delete_constituency(constituency)
      {:error, %Ecto.Changeset{}}

  """
  def delete_constituency(%Constituency{} = constituency) do
    Repo.delete(constituency)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking constituency changes.

  ## Examples

      iex> change_constituency(constituency)
      %Ecto.Changeset{data: %Constituency{}}

  """
  def change_constituency(%Constituency{} = constituency, attrs \\ %{}) do
    Constituency.changeset(constituency, attrs)
  end
end
