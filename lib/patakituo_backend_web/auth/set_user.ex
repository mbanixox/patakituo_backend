defmodule PatakituoBackendWeb.Auth.SetUser do
  @moduledoc """
  Assigns the current user to the connection if a user session exists.

  If the user is not found in the session, it raises an unauthorized error.
  """

  import Plug.Conn

  alias PatakituoBackendWeb.Auth.ErrorResponse
  alias PatakituoBackend.Users

  @doc """
  Initializes options for the plug. No options are used.
  """
  def init(_options) do
  end

  @doc """
  Assigns the user to the connection if a valid `:user_id` is found in the session.

  Raises `ErrorResponse.Unauthorized` if no user is found in the session.
  """
  def call(conn, _options) do
    if conn.assigns[:user] do
      conn
    else
     case Guardian.Plug.current_resource(conn) do
        nil ->
          raise ErrorResponse.Unauthorized

        user ->
          user = Users.get_user!(user.id)
          assign(conn, :user, user)
      end
    end
  end
end
