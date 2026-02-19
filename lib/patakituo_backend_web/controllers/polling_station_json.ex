defmodule PatakituoBackendWeb.PollingStationJSON do
  alias PatakituoBackend.PollingStations.PollingStation

  @doc """
  Renders a list of polling_stations.
  """
  def index(%{polling_stations: polling_stations}) do
    %{data: for(polling_station <- polling_stations, do: data(polling_station))}
  end

  @doc """
  Renders a single polling_station.
  """
  def show(%{polling_station: polling_station}) do
    %{data: data(polling_station)}
  end

  defp data(%PollingStation{} = polling_station) do
    %{
      id: polling_station.id,
      name: polling_station.name
    }
  end
end
