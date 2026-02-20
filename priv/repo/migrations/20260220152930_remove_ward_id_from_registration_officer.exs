defmodule PatakituoBackend.Repo.Migrations.RemoveWardIdFromRegistrationOfficer do
  use Ecto.Migration

  def change do
    alter table(:registration_officers) do
      remove :ward_id
    end
  end
end
