defmodule PatakituoBackendWeb.ConstituencyController do
  use PatakituoBackendWeb, :controller

  alias PatakituoBackend.Constituencies
  alias PatakituoBackend.Constituencies.Constituency

  action_fallback PatakituoBackendWeb.FallbackController

  def index(conn, _params) do
    constituencies = Constituencies.list_constituencies()
    render(conn, :index, constituencies: constituencies)
  end

  def create(conn, %{"constituency" => constituency_params}) do
    with {:ok, %Constituency{} = constituency} <- Constituencies.create_constituency(constituency_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/constituencies/#{constituency}")
      |> render(:show, constituency: constituency)
    end
  end

  def show(conn, %{"id" => id}) do
    constituency = Constituencies.get_constituency!(id)
    render(conn, :show, constituency: constituency)
  end

  def update(conn, %{"id" => id, "constituency" => constituency_params}) do
    constituency = Constituencies.get_constituency!(id)

    with {:ok, %Constituency{} = constituency} <- Constituencies.update_constituency(constituency, constituency_params) do
      render(conn, :show, constituency: constituency)
    end
  end

  def delete(conn, %{"id" => id}) do
    constituency = Constituencies.get_constituency!(id)

    with {:ok, %Constituency{}} <- Constituencies.delete_constituency(constituency) do
      send_resp(conn, :no_content, "")
    end
  end
end
