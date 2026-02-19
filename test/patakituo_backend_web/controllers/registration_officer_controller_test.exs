defmodule PatakituoBackendWeb.RegistrationOfficerControllerTest do
  use PatakituoBackendWeb.ConnCase

  import PatakituoBackend.RegistrationOfficersFixtures
  alias PatakituoBackend.RegistrationOfficers.RegistrationOfficer

  @create_attrs %{
    name: "some name",
    email: "some email"
  }
  @update_attrs %{
    name: "some updated name",
    email: "some updated email"
  }
  @invalid_attrs %{name: nil, email: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all registration_officers", %{conn: conn} do
      conn = get(conn, ~p"/api/registration_officers")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create registration_officer" do
    test "renders registration_officer when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/registration_officers", registration_officer: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/registration_officers/#{id}")

      assert %{
               "id" => ^id,
               "email" => "some email",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/registration_officers", registration_officer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update registration_officer" do
    setup [:create_registration_officer]

    test "renders registration_officer when data is valid", %{conn: conn, registration_officer: %RegistrationOfficer{id: id} = registration_officer} do
      conn = put(conn, ~p"/api/registration_officers/#{registration_officer}", registration_officer: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/registration_officers/#{id}")

      assert %{
               "id" => ^id,
               "email" => "some updated email",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, registration_officer: registration_officer} do
      conn = put(conn, ~p"/api/registration_officers/#{registration_officer}", registration_officer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete registration_officer" do
    setup [:create_registration_officer]

    test "deletes chosen registration_officer", %{conn: conn, registration_officer: registration_officer} do
      conn = delete(conn, ~p"/api/registration_officers/#{registration_officer}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/registration_officers/#{registration_officer}")
      end
    end
  end

  defp create_registration_officer(_) do
    registration_officer = registration_officer_fixture()

    %{registration_officer: registration_officer}
  end
end
