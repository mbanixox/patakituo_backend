defmodule PatakituoBackendWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :patakituo_backend,
    module: PatakituoBackendWeb.Auth.Guardian,
    error_handler: PatakituoBackendWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
