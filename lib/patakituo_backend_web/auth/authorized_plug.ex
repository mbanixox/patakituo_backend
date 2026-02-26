defmodule PatakituoBackendWeb.Auth.AuthorizedPlug do
  @moduledoc """
  Provides plugs for enforcing user authorization on sensitive actions.

  ## Functions

  - `is_authorized_user/2`:
    Ensures that only the owner of a user resource can perform certain actions
    (like update or delete).
    - If the user ID is nested under `"user"` in the params (e.g., `update`),
      checks if `conn.assigns.user.id` matches `params["id"]`.
    - If the user ID is at the top level in the params (e.g., `delete`),
      checks if `conn.assigns.user.id` matches `id`.
    - Raises `Forbidden` if the IDs do not match.

  ## Usage

      plug :is_authorized_user when action in [:update, :delete]

  Use these plugs in controllers to restrict access to actions that should only
  be performed by the resource owner.
  """

  alias PatakituoBackendWeb.Auth.ErrorResponse

  def is_authorized_user(%{params: %{"user" => params}} = conn, _opts) do
    if conn.assigns.user.id == params["id"] do
      conn
    else
      raise ErrorResponse.Forbidden
    end
  end

  def is_authorized_user(%{params: %{"id" => id}} = conn, _opts) do
    if conn.assigns.user.id == id do
      conn
    else
      raise ErrorResponse.Forbidden
    end
  end
end
