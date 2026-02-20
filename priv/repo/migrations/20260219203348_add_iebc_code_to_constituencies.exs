defmodule PatakituoBackend.Repo.Migrations.AddIebcCodeToConstituencies do
  use Ecto.Migration

  def change do
    alter table(:constituencies) do
      add :iebc_code, :integer
    end

    create unique_index(:constituencies, :iebc_code)
  end
end
