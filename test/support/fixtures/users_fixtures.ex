defmodule PatakituoBackend.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PatakituoBackend.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        age: 42,
        email: "some email",
        first_name: "some first_name",
        last_name: "some last_name",
        middle_name: "some middle_name",
        phone_number: "some phone_number"
      })
      |> PatakituoBackend.Users.create_user()

    user
  end
end
