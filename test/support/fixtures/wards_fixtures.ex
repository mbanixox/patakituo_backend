defmodule PatakituoBackend.WardsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PatakituoBackend.Wards` context.
  """

  @doc """
  Generate a ward.
  """
  def ward_fixture(attrs \\ %{}) do
    {:ok, ward} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> PatakituoBackend.Wards.create_ward()

    ward
  end
end
