defmodule PatakituoBackendWeb.CountyJSON do
  alias PatakituoBackend.Counties.County

  @doc """
  Renders a list of counties.
  """
  def index(%{counties: counties}) do
    %{data: for(county <- counties, do: data(county))}
  end

  @doc """
  Renders a single county.
  """
  def show(%{county: county}) do
    %{data: data(county)}
  end

  defp data(%County{} = county) do
    %{
      id: county.id,
      code: county.code,
      name: county.name
    }
  end
end
