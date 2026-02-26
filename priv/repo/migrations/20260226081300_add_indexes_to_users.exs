defmodule PatakituoBackend.Repo.Migrations.AddIndexesToUsers do
  use Ecto.Migration

  def change do
    create(unique_index(:users, [:email]))
    create(index(:users, [:phone_number]))

  end
end
