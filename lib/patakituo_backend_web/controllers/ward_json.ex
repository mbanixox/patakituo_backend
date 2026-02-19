defmodule PatakituoBackendWeb.WardJSON do
  alias PatakituoBackend.Wards.Ward

  @doc """
  Renders a list of wards.
  """
  def index(%{wards: wards}) do
    %{data: for(ward <- wards, do: data(ward))}
  end

  @doc """
  Renders a single ward.
  """
  def show(%{ward: ward}) do
    %{data: data(ward)}
  end

  defp data(%Ward{} = ward) do
    %{
      id: ward.id,
      name: ward.name
    }
  end
end
