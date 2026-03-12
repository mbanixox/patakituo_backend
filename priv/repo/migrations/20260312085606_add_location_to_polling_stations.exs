defmodule PatakituoBackend.Repo.Migrations.AddLocationToPollingStations do
  use Ecto.Migration

  def up do
    alter table(:polling_stations) do
      add :location, :geometry
    end

    create index(:polling_stations, [:location], using: :gist)
  end

  def down do
    drop index(:polling_stations, [:location], using: :gist)

    alter table(:polling_stations) do
      remove :location
    end
  end
end
