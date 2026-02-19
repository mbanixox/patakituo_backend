defmodule PatakituoBackend.PollingStations do
  @moduledoc """
  The PollingStations context.
  """

  import Ecto.Query, warn: false
  alias PatakituoBackend.Repo

  alias PatakituoBackend.PollingStations.PollingStation

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
