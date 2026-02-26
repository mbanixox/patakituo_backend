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
    # Virtual field (:password) - not stored to db
    field :password, :string, virtual: true
    field :hashed_password, :string
    field :phone_number, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :first_name,
      :middle_name,
      :last_name,
      :age,
      :email,
      :password,
      :phone_number
    ])
    |> validate_required([
      :first_name,
      :last_name,
      :age,
      :email,
      :password,
      :phone_number
    ])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 160)
    |> validate_length(:password, min: 8)
    |> put_hashed_password()
  end

  defp put_hashed_password(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, hashed_password: Pbkdf2.hash_pwd_salt(password))
  end

  defp put_hashed_password(changeset), do: changeset
end
