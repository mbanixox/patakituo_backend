defmodule PatakituoBackend.Constituencies.Constituency do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "constituencies" do
    field :name, :string
    field :iebc_code, :integer

    belongs_to :county, PatakituoBackend.Counties.County
    has_many :wards, PatakituoBackend.Wards.Ward
    has_many :registration_officers, PatakituoBackend.RegistrationOfficers.RegistrationOfficer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(constituency, attrs) do
    constituency
    |> cast(attrs, [:name, :iebc_code])
    |> validate_required([:name, :iebc_code])
    |> put_change(:county_id, attrs[:county_id] || attrs["county_id"])
    |> validate_required([:county_id])
    |> unique_constraint(:iebc_code)
  end
end
