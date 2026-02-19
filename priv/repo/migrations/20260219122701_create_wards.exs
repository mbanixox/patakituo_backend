defmodule PatakituoBackend.Repo.Migrations.CreateWards do
  use Ecto.Migration

  def change do
    create table(:wards, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :constituency_id, references(:constituencies, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:wards, [:constituency_id])
  end
end
