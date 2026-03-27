defmodule PatakituoBackend.Workers.GeocodingWorker do
  use Oban.Worker,
    queue: :geocoding,
    max_attempts: 3

  alias PatakituoBackend.PollingStations
  alias PatakituoBackend.Repo
  alias PatakituoBackend.PollingStations.PollingStation
  alias PatakituoBackend.GeocodingService

  import Ecto.Changeset, only: [change: 2]

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"station_id" => id}}) do
    station =
      PollingStations.get_polling_station!(id)
      |> Repo.preload(ward: [constituency: :county])

    query = build_query(station)

    case GeocodingService.geocode(query) do
      {:ok, point} ->
        station
        |> change(location: point, location_available: true)
        |> Repo.update!()
        {:ok, "Location updated for polling station #{id}"}

      {:error, :not_found} ->
        {:error, "Location not found for polling station #{id}"}

      {:error, :api_error} ->
        {:error, "Geocoding API error for polling station #{id}"}
    end
  end

  defp build_query(%PollingStation{name: name, ward: ward}) do
    ward_name = ward.name
    constituency_name = ward.constituency.name
    county_name = ward.constituency.county.name

    "#{name}, #{ward_name}, #{constituency_name}, #{county_name}, Kenya"
  end
end
