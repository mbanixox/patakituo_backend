defmodule PatakituoBackend.Repo.Migrations.CreateConstituencies do
  use Ecto.Migration

  def change do
    create table(:constituencies, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :county_id, references(:counties, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:constituencies, [:county_id])
  end
end
