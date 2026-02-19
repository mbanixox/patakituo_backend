defmodule PatakituoBackendWeb.CountyControllerTest do
  use PatakituoBackendWeb.ConnCase

  import PatakituoBackend.CountiesFixtures
  alias PatakituoBackend.Counties.County

  @create_attrs %{
    code: 42,
    name: "some name"
  }
  @update_attrs %{
    code: 43,
    name: "some updated name"
  }
  @invalid_attrs %{code: nil, name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all counties", %{conn: conn} do
      conn = get(conn, ~p"/api/counties")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create county" do
    test "renders county when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/counties", county: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/counties/#{id}")

      assert %{
               "id" => ^id,
               "code" => 42,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/counties", county: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update county" do
    setup [:create_county]

    test "renders county when data is valid", %{conn: conn, county: %County{id: id} = county} do
      conn = put(conn, ~p"/api/counties/#{county}", county: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/counties/#{id}")

      assert %{
               "id" => ^id,
               "code" => 43,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, county: county} do
      conn = put(conn, ~p"/api/counties/#{county}", county: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete county" do
    setup [:create_county]

    test "deletes chosen county", %{conn: conn, county: county} do
      conn = delete(conn, ~p"/api/counties/#{county}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/counties/#{county}")
      end
    end
  end

  defp create_county(_) do
    county = county_fixture()

    %{county: county}
  end
end
