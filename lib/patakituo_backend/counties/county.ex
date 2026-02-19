defmodule PatakituoBackend.Counties.County do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "counties" do
    field :code, :integer
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(county, attrs) do
    county
    |> cast(attrs, [:name, :code])
    |> validate_required([:name, :code])
  end
end
