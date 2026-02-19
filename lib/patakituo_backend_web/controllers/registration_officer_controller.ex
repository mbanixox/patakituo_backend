defmodule PatakituoBackendWeb.RegistrationOfficerController do
  use PatakituoBackendWeb, :controller

  alias PatakituoBackend.RegistrationOfficers
  alias PatakituoBackend.RegistrationOfficers.RegistrationOfficer

  action_fallback PatakituoBackendWeb.FallbackController

  def index(conn, _params) do
    registration_officers = RegistrationOfficers.list_registration_officers()
    render(conn, :index, registration_officers: registration_officers)
  end

  def create(conn, %{"registration_officer" => registration_officer_params}) do
    with {:ok, %RegistrationOfficer{} = registration_officer} <- RegistrationOfficers.create_registration_officer(registration_officer_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/registration_officers/#{registration_officer}")
      |> render(:show, registration_officer: registration_officer)
    end
  end

  def show(conn, %{"id" => id}) do
    registration_officer = RegistrationOfficers.get_registration_officer!(id)
    render(conn, :show, registration_officer: registration_officer)
  end

  def update(conn, %{"id" => id, "registration_officer" => registration_officer_params}) do
    registration_officer = RegistrationOfficers.get_registration_officer!(id)

    with {:ok, %RegistrationOfficer{} = registration_officer} <- RegistrationOfficers.update_registration_officer(registration_officer, registration_officer_params) do
      render(conn, :show, registration_officer: registration_officer)
    end
  end

  def delete(conn, %{"id" => id}) do
    registration_officer = RegistrationOfficers.get_registration_officer!(id)

    with {:ok, %RegistrationOfficer{}} <- RegistrationOfficers.delete_registration_officer(registration_officer) do
      send_resp(conn, :no_content, "")
    end
  end
end
