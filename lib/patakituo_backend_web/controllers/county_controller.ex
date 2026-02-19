defmodule PatakituoBackendWeb.CountyController do
  use PatakituoBackendWeb, :controller

  alias PatakituoBackend.Counties
  alias PatakituoBackend.Counties.County

  action_fallback PatakituoBackendWeb.FallbackController

  def index(conn, _params) do
    counties = Counties.list_counties()
    render(conn, :index, counties: counties)
  end

  def create(conn, %{"county" => county_params}) do
    with {:ok, %County{} = county} <- Counties.create_county(county_params) do
      conn
      |> put_status(:created)
      |> render(:show, county: county)
    end
  end

  def bulk_create(conn, %{"counties" => counties_params}) when is_list(counties_params) do
    with {:ok, counties} <- Counties.bulk_create_counties(counties_params) do
      conn
      |> put_status(:created)
      |> render(:index, counties: counties)
    end
  end

  def show(conn, %{"id" => id}) do
    county = Counties.get_county!(id)
    render(conn, :show, county: county)
  end

  def update(conn, %{"id" => id, "county" => county_params}) do
    county = Counties.get_county!(id)

    with {:ok, %County{} = county} <- Counties.update_county(county, county_params) do
      render(conn, :show, county: county)
    end
  end

  def delete(conn, %{"id" => id}) do
    county = Counties.get_county!(id)

    with {:ok, %County{}} <- Counties.delete_county(county) do
      send_resp(conn, :no_content, "")
    end
  end
end
