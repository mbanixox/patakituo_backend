defmodule PatakituoBackend.Repo.Migrations.AddIebcCodeToWards do
  use Ecto.Migration

  def change do
    alter table(:wards) do
      add :iebc_code, :integer
    end

    create unique_index(:wards, :iebc_code)

  end
end
