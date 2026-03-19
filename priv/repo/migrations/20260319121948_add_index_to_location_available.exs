defmodule PatakituoBackend.Repo.Migrations.AddIndexToLocationAvailable do
  use Ecto.Migration

  def change do
    create(index(:polling_stations, [:location_available]))
  end
end
