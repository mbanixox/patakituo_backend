defmodule PatakituoBackendWeb.WardControllerTest do
  use PatakituoBackendWeb.ConnCase

  import PatakituoBackend.WardsFixtures
  alias PatakituoBackend.Wards.Ward

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all wards", %{conn: conn} do
      conn = get(conn, ~p"/api/wards")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create ward" do
    test "renders ward when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/wards", ward: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/wards/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/wards", ward: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update ward" do
    setup [:create_ward]

    test "renders ward when data is valid", %{conn: conn, ward: %Ward{id: id} = ward} do
      conn = put(conn, ~p"/api/wards/#{ward}", ward: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/wards/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, ward: ward} do
      conn = put(conn, ~p"/api/wards/#{ward}", ward: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete ward" do
    setup [:create_ward]

    test "deletes chosen ward", %{conn: conn, ward: ward} do
      conn = delete(conn, ~p"/api/wards/#{ward}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/wards/#{ward}")
      end
    end
  end

  defp create_ward(_) do
    ward = ward_fixture()

    %{ward: ward}
  end
end
