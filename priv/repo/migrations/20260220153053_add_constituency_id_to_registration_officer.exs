defmodule PatakituoBackend.Repo.Migrations.AddConstituencyIdToRegistrationOfficer do
  use Ecto.Migration

  def change do
    alter table(:registration_officers) do
      add :constituency_id, references(:constituencies, type: :binary_id, on_delete: :delete_all)
    end

    create index(:registration_officers, [:constituency_id])
  end
end
