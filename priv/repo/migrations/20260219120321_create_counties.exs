defmodule PatakituoBackend.Repo.Migrations.CreateCounties do
  use Ecto.Migration

  def change do
    create table(:counties, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :code, :integer
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
