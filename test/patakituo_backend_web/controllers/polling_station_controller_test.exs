defmodule PatakituoBackendWeb.PollingStationControllerTest do
  use PatakituoBackendWeb.ConnCase

  import PatakituoBackend.PollingStationsFixtures
  alias PatakituoBackend.PollingStations.PollingStation

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all polling_stations", %{conn: conn} do
      conn = get(conn, ~p"/api/polling_stations")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create polling_station" do
    test "renders polling_station when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/polling_stations", polling_station: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/polling_stations/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/polling_stations", polling_station: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update polling_station" do
    setup [:create_polling_station]

    test "renders polling_station when data is valid", %{conn: conn, polling_station: %PollingStation{id: id} = polling_station} do
      conn = put(conn, ~p"/api/polling_stations/#{polling_station}", polling_station: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/polling_stations/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, polling_station: polling_station} do
      conn = put(conn, ~p"/api/polling_stations/#{polling_station}", polling_station: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete polling_station" do
    setup [:create_polling_station]

    test "deletes chosen polling_station", %{conn: conn, polling_station: polling_station} do
      conn = delete(conn, ~p"/api/polling_stations/#{polling_station}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/polling_stations/#{polling_station}")
      end
    end
  end

  defp create_polling_station(_) do
    polling_station = polling_station_fixture()

    %{polling_station: polling_station}
  end
end
