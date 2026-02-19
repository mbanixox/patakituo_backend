defmodule PatakituoBackend.Repo.Migrations.AddIsActiveBoolToRegistrationOfficer do
  use Ecto.Migration

  def change do
    alter table(:registration_officers) do
      add :is_active, :boolean, default: true, null: false
    end

  end
end
