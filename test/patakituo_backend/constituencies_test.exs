defmodule PatakituoBackend.ConstituenciesTest do
  use PatakituoBackend.DataCase

  alias PatakituoBackend.Constituencies

  describe "constituencies" do
    alias PatakituoBackend.Constituencies.Constituency

    import PatakituoBackend.ConstituenciesFixtures

    @invalid_attrs %{name: nil}

    test "list_constituencies/0 returns all constituencies" do
      constituency = constituency_fixture()
      assert Constituencies.list_constituencies() == [constituency]
    end

    test "get_constituency!/1 returns the constituency with given id" do
      constituency = constituency_fixture()
      assert Constituencies.get_constituency!(constituency.id) == constituency
    end

    test "create_constituency/1 with valid data creates a constituency" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Constituency{} = constituency} = Constituencies.create_constituency(valid_attrs)
      assert constituency.name == "some name"
    end

    test "create_constituency/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Constituencies.create_constituency(@invalid_attrs)
    end

    test "update_constituency/2 with valid data updates the constituency" do
      constituency = constituency_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Constituency{} = constituency} = Constituencies.update_constituency(constituency, update_attrs)
      assert constituency.name == "some updated name"
    end

    test "update_constituency/2 with invalid data returns error changeset" do
      constituency = constituency_fixture()
      assert {:error, %Ecto.Changeset{}} = Constituencies.update_constituency(constituency, @invalid_attrs)
      assert constituency == Constituencies.get_constituency!(constituency.id)
    end

    test "delete_constituency/1 deletes the constituency" do
      constituency = constituency_fixture()
      assert {:ok, %Constituency{}} = Constituencies.delete_constituency(constituency)
      assert_raise Ecto.NoResultsError, fn -> Constituencies.get_constituency!(constituency.id) end
    end

    test "change_constituency/1 returns a constituency changeset" do
      constituency = constituency_fixture()
      assert %Ecto.Changeset{} = Constituencies.change_constituency(constituency)
    end
  end
end
