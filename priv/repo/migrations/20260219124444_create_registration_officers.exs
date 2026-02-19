defmodule PatakituoBackend.Repo.Migrations.CreateRegistrationOfficers do
  use Ecto.Migration

  def change do
    create table(:registration_officers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :email, :string
      add :ward_id, references(:wards, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:registration_officers, [:ward_id])
  end
end
