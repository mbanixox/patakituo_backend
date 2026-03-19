defmodule PatakituoBackend.Repo.Migrations.AddLocationAvailableToPollingStations do
  use Ecto.Migration

  def change do
    alter table(:polling_stations) do
      add :location_available, :boolean, default: false, null: false
    end
  end
end
