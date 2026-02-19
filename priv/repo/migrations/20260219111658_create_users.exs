defmodule PatakituoBackend.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :first_name, :string
      add :middle_name, :string
      add :last_name, :string
      add :age, :integer
      add :email, :string
      add :phone_number, :string

      timestamps(type: :utc_datetime)
    end
  end
end
