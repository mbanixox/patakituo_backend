defmodule PatakituoBackend.ConstituenciesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PatakituoBackend.Constituencies` context.
  """

  @doc """
  Generate a constituency.
  """
  def constituency_fixture(attrs \\ %{}) do
    {:ok, constituency} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> PatakituoBackend.Constituencies.create_constituency()

    constituency
  end
end
