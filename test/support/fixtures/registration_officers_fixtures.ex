defmodule PatakituoBackend.RegistrationOfficersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PatakituoBackend.RegistrationOfficers` context.
  """

  @doc """
  Generate a registration_officer.
  """
  def registration_officer_fixture(attrs \\ %{}) do
    {:ok, registration_officer} =
      attrs
      |> Enum.into(%{
        email: "some email",
        name: "some name"
      })
      |> PatakituoBackend.RegistrationOfficers.create_registration_officer()

    registration_officer
  end
end
