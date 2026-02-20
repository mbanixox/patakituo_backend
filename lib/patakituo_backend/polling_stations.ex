defmodule PatakituoBackend.PollingStations do
  @moduledoc """
  The PollingStations context.
  """

  import Ecto.Query, warn: false
  alias PatakituoBackend.Repo

  alias PatakituoBackend.PollingStations.PollingStation
  alias PatakituoBackend.Wards.Ward
  alias PatakituoBackend.IebcScrapper

  @doc """
  Returns the list of polling_stations.

  ## Examples

      iex> list_polling_stations()
      [%PollingStation{}, ...]

  """
  def list_polling_stations do
    Repo.all(PollingStation)
  end

  @doc """
  Gets a single polling_station.

  Raises `Ecto.NoResultsError` if the Polling station does not exist.

  ## Examples

      iex> get_polling_station!(123)
      %PollingStation{}

      iex> get_polling_station!(456)
      ** (Ecto.NoResultsError)

  """
  def get_polling_station!(id), do: Repo.get!(PollingStation, id)

  @doc """
  Creates a polling_station.

  ## Examples

      iex> create_polling_station(%{field: value})
      {:ok, %PollingStation{}}

      iex> create_polling_station(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_polling_station(attrs) do
    %PollingStation{}
    |> PollingStation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates multiple polling stations for a given ward.

  ## Examples

      iex> bulk_create_polling_stations("001", [%{name: "Station 1"}, %{name: "Station 2"}])
      {:ok, [%PollingStation{}, %PollingStation{}]}

      iex> bulk_create_polling_stations("001", [%{name: "Invalid Station"}])
      {:error, %Ecto.Changeset{}}

  """
  def bulk_create_polling_stations(ward_code, attrs_list) when is_list(attrs_list) do
    case Repo.get_by(Ward, iebc_code: ward_code) do
      nil ->
        {:error, "Ward with code #{ward_code} not found"}

      %Ward{id: ward_id} ->
        Repo.transaction(fn ->
          Enum.map(attrs_list, fn attrs ->
            attrs_with_ward = Map.put(attrs, :ward_id, ward_id)

            case create_polling_station(attrs_with_ward) do
              {:ok, polling_station} -> polling_station
              {:error, changeset} -> Repo.rollback(changeset)
            end
          end)
        end)
    end
  end

  @doc """
  Fetches and creates all polling stations for all wards from IEBC.

  ## Examples

      iex> fetch_all_polling_stations()
      {:ok, %{success: [...], failed: [...]}}

  """
  def fetch_all_polling_stations do
    wards = Repo.all(Ward)

    results =
      Task.async_stream(
        wards,
        fn %Ward{iebc_code: code} -> {code, IebcScrapper.fetch_polling_stations(code)} end,
        timeout: :infinity
      )
      |> Enum.reduce(%{success: [], failed: []}, fn
        {:ok, {_code, {:ok, stations}}}, acc ->
          %{acc | success: acc.success ++ stations}

        {:ok, {code, {:error, reason}}}, acc ->
          %{acc | failed: acc.failed ++ [%{ward_code: code, reason: reason}]}

        {:exit, reason}, acc ->
          %{acc | failed: acc.failed ++ [%{ward_code: :unknown, reason: inspect(reason)}]}
      end)

    {:ok, results}
  end

  @doc """
  Updates a polling_station.

  ## Examples

      iex> update_polling_station(polling_station, %{field: new_value})
      {:ok, %PollingStation{}}

      iex> update_polling_station(polling_station, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_polling_station(%PollingStation{} = polling_station, attrs) do
    polling_station
    |> PollingStation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a polling_station.

  ## Examples

      iex> delete_polling_station(polling_station)
      {:ok, %PollingStation{}}

      iex> delete_polling_station(polling_station)
      {:error, %Ecto.Changeset{}}

  """
  def delete_polling_station(%PollingStation{} = polling_station) do
    Repo.delete(polling_station)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking polling_station changes.

  ## Examples

      iex> change_polling_station(polling_station)
      %Ecto.Changeset{data: %PollingStation{}}

  """
  def change_polling_station(%PollingStation{} = polling_station, attrs \\ %{}) do
    PollingStation.changeset(polling_station, attrs)
  end
end
