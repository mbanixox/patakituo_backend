defmodule PatakituoBackend.Constituencies.Constituency do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "constituencies" do
    field :name, :string

    belongs_to :county, PatakituoBackend.Counties.County

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(constituency, attrs) do
    constituency
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
