defmodule PatakituoBackend.PollingStationsTest do
  use PatakituoBackend.DataCase

  alias PatakituoBackend.PollingStations

  describe "polling_stations" do
    alias PatakituoBackend.PollingStations.PollingStation

    import PatakituoBackend.PollingStationsFixtures

    @invalid_attrs %{name: nil}

    test "list_polling_stations/0 returns all polling_stations" do
      polling_station = polling_station_fixture()
      assert PollingStations.list_polling_stations() == [polling_station]
    end

    test "get_polling_station!/1 returns the polling_station with given id" do
      polling_station = polling_station_fixture()
      assert PollingStations.get_polling_station!(polling_station.id) == polling_station
    end

    test "create_polling_station/1 with valid data creates a polling_station" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %PollingStation{} = polling_station} = PollingStations.create_polling_station(valid_attrs)
      assert polling_station.name == "some name"
    end

    test "create_polling_station/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PollingStations.create_polling_station(@invalid_attrs)
    end

    test "update_polling_station/2 with valid data updates the polling_station" do
      polling_station = polling_station_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %PollingStation{} = polling_station} = PollingStations.update_polling_station(polling_station, update_attrs)
      assert polling_station.name == "some updated name"
    end

    test "update_polling_station/2 with invalid data returns error changeset" do
      polling_station = polling_station_fixture()
      assert {:error, %Ecto.Changeset{}} = PollingStations.update_polling_station(polling_station, @invalid_attrs)
      assert polling_station == PollingStations.get_polling_station!(polling_station.id)
    end

    test "delete_polling_station/1 deletes the polling_station" do
      polling_station = polling_station_fixture()
      assert {:ok, %PollingStation{}} = PollingStations.delete_polling_station(polling_station)
      assert_raise Ecto.NoResultsError, fn -> PollingStations.get_polling_station!(polling_station.id) end
    end

    test "change_polling_station/1 returns a polling_station changeset" do
      polling_station = polling_station_fixture()
      assert %Ecto.Changeset{} = PollingStations.change_polling_station(polling_station)
    end
  end
end
