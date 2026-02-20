defmodule PatakituoBackend.Wards do
  @moduledoc """
  The Wards context.
  """

  import Ecto.Query, warn: false
  alias PatakituoBackend.Repo

  alias PatakituoBackend.Wards.Ward
  alias PatakituoBackend.Constituencies.Constituency

  alias PatakituoBackend.IebcScrapper

  @doc """
  Returns the list of wards.

  ## Examples

      iex> list_wards()
      [%Ward{}, ...]

  """
  def list_wards do
    Repo.all(Ward)
  end

  @doc """
  Gets a single ward.

  Raises `Ecto.NoResultsError` if the Ward does not exist.

  ## Examples

      iex> get_ward!(123)
      %Ward{}

      iex> get_ward!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ward!(id), do: Repo.get!(Ward, id)

  @doc """
  Creates a ward.

  ## Examples

      iex> create_ward(%{field: value})
      {:ok, %Ward{}}

      iex> create_ward(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ward(attrs) do
    %Ward{}
    |> Ward.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates multiple wards for a given constituency.

  ## Examples

      iex> bulk_create_wards("001", [%{iebc_code: 1, name: "Ward 1"}, %{iebc_code: 2, name: "Ward 2"}])
      {:ok, [%Ward{}, %Ward{}]}

      iex> bulk_create_wards("001", [%{iebc_code: nil, name: "Invalid Ward"}])
      {:error, %Ecto.Changeset{}}

  """
  def bulk_create_wards(constituency_iebc_code, attrs_list) when is_list(attrs_list) do
    case Repo.get_by(Constituency, iebc_code: constituency_iebc_code) do
      nil ->
        {:error, "Constituency with iebc code #{constituency_iebc_code} not found"}

      %Constituency{id: constituency_id} ->
        Repo.transaction(fn ->
          Enum.map(attrs_list, fn attrs ->
            attrs_with_constituency = Map.put(attrs, :constituency_id, constituency_id)

            case create_ward(attrs_with_constituency) do
              {:ok, ward} -> ward
              {:error, changeset} -> Repo.rollback(changeset)
            end
          end)
        end)
    end
  end

  @doc """
  Fetches and creates all wards for all constituencies from IEBC.

  ## Examples

      iex> fetch_all_wards()
      {:ok, %{success: [...], failed: [...]}}

  """
  def fetch_all_wards do
    constituencies = Repo.all(Constituency)

    results =
      Task.async_stream(
        constituencies,
        fn %Constituency{iebc_code: iebc_code} -> {iebc_code, IebcScrapper.fetch_wards(iebc_code)} end,
        timeout: :infinity
      )
      |> Enum.reduce(%{success: [], failed: []}, fn
        {:ok, {_code, {:ok, wards}}}, acc ->
          %{acc | success: acc.success ++ wards}

        {:ok, {iebc_code, {:error, reason}}}, acc ->
          %{acc | failed: acc.failed ++ [%{constituency_iebc_code: iebc_code, reason: reason}]}

        {:exit, reason}, acc ->
          %{acc | failed: acc.failed ++ [%{constituency_iebc_code: :unknown, reason: inspect(reason)}]}
      end)

    {:ok, results}
  end

  @doc """
  Updates a ward.

  ## Examples

      iex> update_ward(ward, %{field: new_value})
      {:ok, %Ward{}}

      iex> update_ward(ward, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ward(%Ward{} = ward, attrs) do
    ward
    |> Ward.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ward.

  ## Examples

      iex> delete_ward(ward)
      {:ok, %Ward{}}

      iex> delete_ward(ward)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ward(%Ward{} = ward) do
    Repo.delete(ward)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ward changes.

  ## Examples

      iex> change_ward(ward)
      %Ecto.Changeset{data: %Ward{}}

  """
  def change_ward(%Ward{} = ward, attrs \\ %{}) do
    Ward.changeset(ward, attrs)
  end
end
