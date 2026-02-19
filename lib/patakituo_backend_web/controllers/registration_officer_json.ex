defmodule PatakituoBackendWeb.RegistrationOfficerJSON do
  alias PatakituoBackend.RegistrationOfficers.RegistrationOfficer

  @doc """
  Renders a list of registration_officers.
  """
  def index(%{registration_officers: registration_officers}) do
    %{data: for(registration_officer <- registration_officers, do: data(registration_officer))}
  end

  @doc """
  Renders a single registration_officer.
  """
  def show(%{registration_officer: registration_officer}) do
    %{data: data(registration_officer)}
  end

  defp data(%RegistrationOfficer{} = registration_officer) do
    %{
      id: registration_officer.id,
      name: registration_officer.name,
      email: registration_officer.email
    }
  end
end
