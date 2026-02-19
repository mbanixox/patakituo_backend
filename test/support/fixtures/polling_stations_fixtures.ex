defmodule PatakituoBackend.PollingStationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PatakituoBackend.PollingStations` context.
  """

  @doc """
  Generate a polling_station.
  """
  def polling_station_fixture(attrs \\ %{}) do
    {:ok, polling_station} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> PatakituoBackend.PollingStations.create_polling_station()

    polling_station
  end
end
