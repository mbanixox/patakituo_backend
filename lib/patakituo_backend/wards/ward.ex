defmodule PatakituoBackend.Wards.Ward do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "wards" do
    field :name, :string

    belongs_to :constituency, PatakituoBackend.Constituencies.Constituency
    has_many :polling_stations, PatakituoBackend.PollingStations.PollingStation
    has_many :registration_officers, PatakituoBackend.RegistrationOfficers.RegistrationOfficer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(ward, attrs) do
    ward
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
