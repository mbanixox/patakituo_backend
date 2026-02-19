defmodule PatakituoBackend.PollingStations.PollingStation do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "polling_stations" do
    field :name, :string
    field :is_active, :boolean, default: true

    belongs_to :ward, PatakituoBackend.Wards.Ward

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(polling_station, attrs) do
    polling_station
    |> cast(attrs, [:name, :is_active])
    |> validate_required([:name, :is_active])
  end
end
