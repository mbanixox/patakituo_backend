defmodule PatakituoBackendWeb.WardController do
  use PatakituoBackendWeb, :controller

  alias PatakituoBackend.Wards
  alias PatakituoBackend.Wards.Ward

  action_fallback PatakituoBackendWeb.FallbackController

  def index(conn, _params) do
    wards = Wards.list_wards()
    render(conn, :index, wards: wards)
  end

  def create(conn, %{"ward" => ward_params}) do
    with {:ok, %Ward{} = ward} <- Wards.create_ward(ward_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/wards/#{ward}")
      |> render(:show, ward: ward)
    end
  end

  def show(conn, %{"id" => id}) do
    ward = Wards.get_ward!(id)
    render(conn, :show, ward: ward)
  end

  def update(conn, %{"id" => id, "ward" => ward_params}) do
    ward = Wards.get_ward!(id)

    with {:ok, %Ward{} = ward} <- Wards.update_ward(ward, ward_params) do
      render(conn, :show, ward: ward)
    end
  end

  def delete(conn, %{"id" => id}) do
    ward = Wards.get_ward!(id)

    with {:ok, %Ward{}} <- Wards.delete_ward(ward) do
      send_resp(conn, :no_content, "")
    end
  end
end
