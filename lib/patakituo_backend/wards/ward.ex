defmodule PatakituoBackend.Wards.Ward do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "wards" do
    field :name, :string
    field :iebc_code, :integer

    belongs_to :constituency, PatakituoBackend.Constituencies.Constituency
    has_many :polling_stations, PatakituoBackend.PollingStations.PollingStation
    has_many :registration_officers, PatakituoBackend.RegistrationOfficers.RegistrationOfficer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(ward, attrs) do
    ward
    |> cast(attrs, [:name, :iebc_code])
    |> validate_required([:name, :iebc_code])
    |> unique_constraint(:iebc_code)
    |> put_change(:constituency_id, attrs[:constituency_id] || attrs["constituency_id"])
    |> validate_required([:constituency_id])
  end
end
