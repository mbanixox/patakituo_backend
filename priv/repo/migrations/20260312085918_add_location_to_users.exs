defmodule PatakituoBackend.Repo.Migrations.AddLocationToUsers do
  use Ecto.Migration

  def up do
    alter table(:users) do
      add :location, :geometry
    end

    create index(:users, [:location], using: :gist)
  end

  def down do
    drop index(:users, [:location], using: :gist)

    alter table(:users) do
      remove :location
    end
  end
end
