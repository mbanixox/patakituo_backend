defmodule PatakituoBackend.CountiesTest do
  use PatakituoBackend.DataCase

  alias PatakituoBackend.Counties

  describe "counties" do
    alias PatakituoBackend.Counties.County

    import PatakituoBackend.CountiesFixtures

    @invalid_attrs %{code: nil, name: nil}

    test "list_counties/0 returns all counties" do
      county = county_fixture()
      assert Counties.list_counties() == [county]
    end

    test "get_county!/1 returns the county with given id" do
      county = county_fixture()
      assert Counties.get_county!(county.id) == county
    end

    test "create_county/1 with valid data creates a county" do
      valid_attrs = %{code: 42, name: "some name"}

      assert {:ok, %County{} = county} = Counties.create_county(valid_attrs)
      assert county.code == 42
      assert county.name == "some name"
    end

    test "create_county/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Counties.create_county(@invalid_attrs)
    end

    test "update_county/2 with valid data updates the county" do
      county = county_fixture()
      update_attrs = %{code: 43, name: "some updated name"}

      assert {:ok, %County{} = county} = Counties.update_county(county, update_attrs)
      assert county.code == 43
      assert county.name == "some updated name"
    end

    test "update_county/2 with invalid data returns error changeset" do
      county = county_fixture()
      assert {:error, %Ecto.Changeset{}} = Counties.update_county(county, @invalid_attrs)
      assert county == Counties.get_county!(county.id)
    end

    test "delete_county/1 deletes the county" do
      county = county_fixture()
      assert {:ok, %County{}} = Counties.delete_county(county)
      assert_raise Ecto.NoResultsError, fn -> Counties.get_county!(county.id) end
    end

    test "change_county/1 returns a county changeset" do
      county = county_fixture()
      assert %Ecto.Changeset{} = Counties.change_county(county)
    end
  end
end
