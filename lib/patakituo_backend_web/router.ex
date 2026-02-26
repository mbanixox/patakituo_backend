defmodule PatakituoBackendWeb.Router do
  use PatakituoBackendWeb, :router

  use Plug.ErrorHandler

  @doc """
  Handles errors that occur during request processing.

  ## Clauses

  - `Phoenix.Router.NoRouteError` — returns 404 when no route matches
  - `Phoenix.ActionClauseError` — returns 400 for missing or invalid request body
  - Errors with a `message` field — returns the message as JSON
  - All other errors — returns a generic 500 response

  ## Example responses

      {"errors": "no route found for POST /api/unknown (PatakituoBackendWeb.Router)"}
      {"errors": "missing or invalid request body"}
      {"errors": "some error message"}
      {"errors": "internal server error"}
  """
  def handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn
    |> json(%{errors: message})
    |> halt()
  end

  def handle_errors(conn, %{reason: %Phoenix.ActionClauseError{}}) do
    conn
    |> json(%{errors: "missing or invalid request body"})
    |> halt()
  end

  def handle_errors(conn, %{reason: %Plug.Parsers.ParseError{}}) do
    conn
    |> json(%{errors: "malformed request body"})
    |> halt()
  end

  def handle_errors(conn, %{reason: %{message: message}}) do
    conn
    |> json(%{errors: message})
    |> halt()
  end

  def handle_errors(conn, %{reason: reason}) do
    conn
    |> json(%{errors: Exception.message(reason)})
    |> halt()
  end

  def handle_errors(conn, _reason) do
    conn
    |> json(%{errors: "internal server error"})
    |> halt()
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug PatakituoBackendWeb.Auth.Pipeline
  end

  scope "/api", PatakituoBackendWeb do
    pipe_through :api

    post "/users/create", UserController, :create
    post "/sign_in", UserController, :sign_in
  end

  scope "/api", PatakituoBackendWeb do
    pipe_through [:api, :auth]

    post "/counties/bulk_create", CountyController, :bulk_create
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:patakituo_backend, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: PatakituoBackendWeb.Telemetry
    end
  end
end
