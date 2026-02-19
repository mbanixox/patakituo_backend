defmodule PatakituoBackendWeb.ConstituencyControllerTest do
  use PatakituoBackendWeb.ConnCase

  import PatakituoBackend.ConstituenciesFixtures
  alias PatakituoBackend.Constituencies.Constituency

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
    test "lists all constituencies", %{conn: conn} do
      conn = get(conn, ~p"/api/constituencies")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create constituency" do
    test "renders constituency when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/constituencies", constituency: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/constituencies/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/constituencies", constituency: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update constituency" do
    setup [:create_constituency]

    test "renders constituency when data is valid", %{conn: conn, constituency: %Constituency{id: id} = constituency} do
      conn = put(conn, ~p"/api/constituencies/#{constituency}", constituency: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/constituencies/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, constituency: constituency} do
      conn = put(conn, ~p"/api/constituencies/#{constituency}", constituency: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete constituency" do
    setup [:create_constituency]

    test "deletes chosen constituency", %{conn: conn, constituency: constituency} do
      conn = delete(conn, ~p"/api/constituencies/#{constituency}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/constituencies/#{constituency}")
      end
    end
  end

  defp create_constituency(_) do
    constituency = constituency_fixture()

    %{constituency: constituency}
  end
end
