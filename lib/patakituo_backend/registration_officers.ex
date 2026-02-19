defmodule PatakituoBackend.RegistrationOfficers do
  @moduledoc """
  The RegistrationOfficers context.
  """

  import Ecto.Query, warn: false
  alias PatakituoBackend.Repo

  alias PatakituoBackend.RegistrationOfficers.RegistrationOfficer

  @doc """
  Returns the list of registration_officers.

  ## Examples

      iex> list_registration_officers()
      [%RegistrationOfficer{}, ...]

  """
  def list_registration_officers do
    Repo.all(RegistrationOfficer)
  end

  @doc """
  Gets a single registration_officer.

  Raises `Ecto.NoResultsError` if the Registration officer does not exist.

  ## Examples

      iex> get_registration_officer!(123)
      %RegistrationOfficer{}

      iex> get_registration_officer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_registration_officer!(id), do: Repo.get!(RegistrationOfficer, id)

  @doc """
  Creates a registration_officer.

  ## Examples

      iex> create_registration_officer(%{field: value})
      {:ok, %RegistrationOfficer{}}

      iex> create_registration_officer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_registration_officer(attrs) do
    %RegistrationOfficer{}
    |> RegistrationOfficer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a registration_officer.

  ## Examples

      iex> update_registration_officer(registration_officer, %{field: new_value})
      {:ok, %RegistrationOfficer{}}

      iex> update_registration_officer(registration_officer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_registration_officer(%RegistrationOfficer{} = registration_officer, attrs) do
    registration_officer
    |> RegistrationOfficer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a registration_officer.

  ## Examples

      iex> delete_registration_officer(registration_officer)
      {:ok, %RegistrationOfficer{}}

      iex> delete_registration_officer(registration_officer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_registration_officer(%RegistrationOfficer{} = registration_officer) do
    Repo.delete(registration_officer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking registration_officer changes.

  ## Examples

      iex> change_registration_officer(registration_officer)
      %Ecto.Changeset{data: %RegistrationOfficer{}}

  """
  def change_registration_officer(%RegistrationOfficer{} = registration_officer, attrs \\ %{}) do
    RegistrationOfficer.changeset(registration_officer, attrs)
  end
end
