defmodule PatakituoBackendWeb.PollingStationController do
  use PatakituoBackendWeb, :controller

  alias PatakituoBackend.PollingStations
  alias PatakituoBackend.PollingStations.PollingStation

  action_fallback PatakituoBackendWeb.FallbackController

  def index(conn, _params) do
    polling_stations = PollingStations.list_polling_stations()
    render(conn, :index, polling_stations: polling_stations)
  end

  def create(conn, %{"polling_station" => polling_station_params}) do
    with {:ok, %PollingStation{} = polling_station} <- PollingStations.create_polling_station(polling_station_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/polling_stations/#{polling_station}")
      |> render(:show, polling_station: polling_station)
    end
  end

  def show(conn, %{"id" => id}) do
    polling_station = PollingStations.get_polling_station!(id)
    render(conn, :show, polling_station: polling_station)
  end

  def update(conn, %{"id" => id, "polling_station" => polling_station_params}) do
    polling_station = PollingStations.get_polling_station!(id)

    with {:ok, %PollingStation{} = polling_station} <- PollingStations.update_polling_station(polling_station, polling_station_params) do
      render(conn, :show, polling_station: polling_station)
    end
  end

  def delete(conn, %{"id" => id}) do
    polling_station = PollingStations.get_polling_station!(id)

    with {:ok, %PollingStation{}} <- PollingStations.delete_polling_station(polling_station) do
      send_resp(conn, :no_content, "")
    end
  end
end
