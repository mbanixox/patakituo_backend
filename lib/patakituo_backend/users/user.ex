defmodule PatakituoBackend.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :first_name, :string
    field :middle_name, :string
    field :last_name, :string
    field :age, :integer
    field :email, :string
    field :phone_number, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :middle_name, :last_name, :age, :email, :phone_number])
    |> validate_required([:first_name, :middle_name, :last_name, :age, :email, :phone_number])
  end
end
