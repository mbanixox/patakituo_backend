defmodule PatakituoBackend.Repo.Migrations.AddIsActiveBoolToPollingStation do
  use Ecto.Migration

  def change do
    alter table(:polling_stations) do
      add :is_active, :boolean, default: true, null: false
    end
  end
end
