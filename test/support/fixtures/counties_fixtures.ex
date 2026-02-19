defmodule PatakituoBackend.CountiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PatakituoBackend.Counties` context.
  """

  @doc """
  Generate a county.
  """
  def county_fixture(attrs \\ %{}) do
    {:ok, county} =
      attrs
      |> Enum.into(%{
        code: 42,
        name: "some name"
      })
      |> PatakituoBackend.Counties.create_county()

    county
  end
end
