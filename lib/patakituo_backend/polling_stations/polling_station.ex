defmodule PatakituoBackend.PollingStations.PollingStation do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "polling_stations" do
    field :name, :string
    field :is_active, :boolean, default: true
    field :location, Geo.PostGIS.Geometry
    field :latitude, :float, virtual: true
    field :longitude, :float, virtual: true
    field :location_available, :boolean, default: false

    belongs_to :ward, PatakituoBackend.Wards.Ward

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(polling_station, attrs) do
    polling_station
    |> cast(attrs, [:name, :is_active, :latitude, :longitude, :location_available])
    |> validate_required([:name, :is_active])
    |> put_change(:ward_id, attrs[:ward_id] || attrs["ward_id"])
    |> validate_required([:ward_id])
    |> put_location()
  end

  defp put_location(%Ecto.Changeset{changes: %{latitude: lat, longitude: lon}} = changeset)
       when is_float(lat) and is_float(lon) do
    point = %Geo.Point{coordinates: {lon, lat}, srid: 4326}

    changeset
    |> put_change(:location, point)
    |> put_change(:location_available, true)
  end

  defp put_location(changeset), do: changeset
end
