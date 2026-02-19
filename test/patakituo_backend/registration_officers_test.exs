defmodule PatakituoBackend.RegistrationOfficersTest do
  use PatakituoBackend.DataCase

  alias PatakituoBackend.RegistrationOfficers

  describe "registration_officers" do
    alias PatakituoBackend.RegistrationOfficers.RegistrationOfficer

    import PatakituoBackend.RegistrationOfficersFixtures

    @invalid_attrs %{name: nil, email: nil}

    test "list_registration_officers/0 returns all registration_officers" do
      registration_officer = registration_officer_fixture()
      assert RegistrationOfficers.list_registration_officers() == [registration_officer]
    end

    test "get_registration_officer!/1 returns the registration_officer with given id" do
      registration_officer = registration_officer_fixture()
      assert RegistrationOfficers.get_registration_officer!(registration_officer.id) == registration_officer
    end

    test "create_registration_officer/1 with valid data creates a registration_officer" do
      valid_attrs = %{name: "some name", email: "some email"}

      assert {:ok, %RegistrationOfficer{} = registration_officer} = RegistrationOfficers.create_registration_officer(valid_attrs)
      assert registration_officer.name == "some name"
      assert registration_officer.email == "some email"
    end

    test "create_registration_officer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = RegistrationOfficers.create_registration_officer(@invalid_attrs)
    end

    test "update_registration_officer/2 with valid data updates the registration_officer" do
      registration_officer = registration_officer_fixture()
      update_attrs = %{name: "some updated name", email: "some updated email"}

      assert {:ok, %RegistrationOfficer{} = registration_officer} = RegistrationOfficers.update_registration_officer(registration_officer, update_attrs)
      assert registration_officer.name == "some updated name"
      assert registration_officer.email == "some updated email"
    end

    test "update_registration_officer/2 with invalid data returns error changeset" do
      registration_officer = registration_officer_fixture()
      assert {:error, %Ecto.Changeset{}} = RegistrationOfficers.update_registration_officer(registration_officer, @invalid_attrs)
      assert registration_officer == RegistrationOfficers.get_registration_officer!(registration_officer.id)
    end

    test "delete_registration_officer/1 deletes the registration_officer" do
      registration_officer = registration_officer_fixture()
      assert {:ok, %RegistrationOfficer{}} = RegistrationOfficers.delete_registration_officer(registration_officer)
      assert_raise Ecto.NoResultsError, fn -> RegistrationOfficers.get_registration_officer!(registration_officer.id) end
    end

    test "change_registration_officer/1 returns a registration_officer changeset" do
      registration_officer = registration_officer_fixture()
      assert %Ecto.Changeset{} = RegistrationOfficers.change_registration_officer(registration_officer)
    end
  end
end
