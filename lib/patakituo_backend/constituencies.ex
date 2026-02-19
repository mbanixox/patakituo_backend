defmodule PatakituoBackend.Constituencies do
  @moduledoc """
  The Constituencies context.
  """

  import Ecto.Query, warn: false
  alias PatakituoBackend.Repo

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
