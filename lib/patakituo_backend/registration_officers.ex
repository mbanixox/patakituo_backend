defmodule PatakituoBackend.RegistrationOfficers do
  @moduledoc """
  The RegistrationOfficers context.
  """

  import Ecto.Query, warn: false
  alias PatakituoBackend.Repo

  alias PatakituoBackend.RegistrationOfficers.RegistrationOfficer
  alias PatakituoBackend.Constituencies.Constituency
  alias PatakituoBackend.IebcScrapper

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
  Creates multiple registration officers for a given constituency.

  ## Examples

      iex> bulk_create_registration_officers("001", [%{name: "Officer 1", email: "officer1@example.com"}, %{name: "Officer 2", email: "officer2@example.com "}])
      {:ok, [%RegistrationOfficer{}, %RegistrationOfficer{}]}

      iex> bulk_create_registration_officers("001", [%{name: nil, email: nil}])
      {:error, %Ecto.Changeset{}}

  """
  def bulk_create_registration_officers(constituency_iebc_code, attrs_list) when is_list(attrs_list) do
    case Repo.get_by(Constituency, iebc_code: constituency_iebc_code) do
      nil ->
        {:error, "Constituency with iebc code #{constituency_iebc_code} not found"}

      %Constituency{id: constituency_id} ->
        Repo.transaction(fn ->
          Enum.map(attrs_list, fn attrs ->
            attrs_with_constituency = Map.put(attrs, :constituency_id, constituency_id)

            case create_registration_officer(attrs_with_constituency) do
              {:ok, officer} -> officer
              {:error, changeset} -> Repo.rollback(changeset)
            end
          end)
        end)
    end
  end

  @doc """
  Fetches and creates all registration officers for all constituencies from IEBC.

  ## Examples

      iex> fetch_all_registration_officers()
      {:ok, %{success: [...], failed: [...]}}

  """
  def fetch_all_registration_officers do
    constituencies = Repo.all(Constituency)

    results =
      Task.async_stream(
        constituencies,
        fn %Constituency{iebc_code: iebc_code} ->
          {iebc_code, IebcScrapper.fetch_registration_officers(iebc_code)}
        end,
        timeout: :infinity
      )
      |> Enum.reduce(%{success: [], failed: []}, fn
        {:ok, {_code, {:ok, officers}}}, acc ->
          %{acc | success: acc.success ++ officers}

        {:ok, {iebc_code, {:error, reason}}}, acc ->
          %{acc | failed: acc.failed ++ [%{constituency_iebc_code: iebc_code, reason: reason}]}

        {:exit, reason}, acc ->
          %{
            acc
            | failed: acc.failed ++ [%{constituency_iebc_code: :unknown, reason: inspect(reason)}]
          }
      end)

    {:ok, results}
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
