defmodule PatakituoBackendWeb.ConstituencyJSON do
  alias PatakituoBackend.Constituencies.Constituency

  @doc """
  Renders a list of constituencies.
  """
  def index(%{constituencies: constituencies}) do
    %{data: for(constituency <- constituencies, do: data(constituency))}
  end

  @doc """
  Renders a single constituency.
  """
  def show(%{constituency: constituency}) do
    %{data: data(constituency)}
  end

  defp data(%Constituency{} = constituency) do
    %{
      id: constituency.id,
      name: constituency.name
    }
  end
end
