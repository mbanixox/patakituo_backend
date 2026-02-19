defmodule PatakituoBackend.Repo.Migrations.CreatePollingStations do
  use Ecto.Migration

  def change do
    create table(:polling_stations, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :ward_id, references(:wards, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:polling_stations, [:ward_id])
  end
end
