defmodule PatakituoBackend.WardsTest do
  use PatakituoBackend.DataCase

  alias PatakituoBackend.Wards

  describe "wards" do
    alias PatakituoBackend.Wards.Ward

    import PatakituoBackend.WardsFixtures

    @invalid_attrs %{name: nil}

    test "list_wards/0 returns all wards" do
      ward = ward_fixture()
      assert Wards.list_wards() == [ward]
    end

    test "get_ward!/1 returns the ward with given id" do
      ward = ward_fixture()
      assert Wards.get_ward!(ward.id) == ward
    end

    test "create_ward/1 with valid data creates a ward" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Ward{} = ward} = Wards.create_ward(valid_attrs)
      assert ward.name == "some name"
    end

    test "create_ward/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Wards.create_ward(@invalid_attrs)
    end

    test "update_ward/2 with valid data updates the ward" do
      ward = ward_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Ward{} = ward} = Wards.update_ward(ward, update_attrs)
      assert ward.name == "some updated name"
    end

    test "update_ward/2 with invalid data returns error changeset" do
      ward = ward_fixture()
      assert {:error, %Ecto.Changeset{}} = Wards.update_ward(ward, @invalid_attrs)
      assert ward == Wards.get_ward!(ward.id)
    end

    test "delete_ward/1 deletes the ward" do
      ward = ward_fixture()
      assert {:ok, %Ward{}} = Wards.delete_ward(ward)
      assert_raise Ecto.NoResultsError, fn -> Wards.get_ward!(ward.id) end
    end

    test "change_ward/1 returns a ward changeset" do
      ward = ward_fixture()
      assert %Ecto.Changeset{} = Wards.change_ward(ward)
    end
  end
end
