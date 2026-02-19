defmodule PatakituoBackend.RegistrationOfficers.RegistrationOfficer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "registration_officers" do
    field :name, :string
    field :email, :string
    field :is_active, :boolean, default: true

    belongs_to :ward, PatakituoBackend.Wards.Ward

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(registration_officer, attrs) do
    registration_officer
    |> cast(attrs, [:name, :email, :is_active])
    |> validate_required([:name, :email, :is_active])
  end
end
