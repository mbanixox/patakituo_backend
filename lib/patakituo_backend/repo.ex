defmodule PatakituoBackend.Repo do
  use Ecto.Repo,
    otp_app: :patakituo_backend,
    adapter: Ecto.Adapters.Postgres
end
