# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :patakituo_backend,
  ecto_repos: [PatakituoBackend.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true]

config :patakituo_backend, :iebc_base_url,
  System.get_env("IEBC_BASE_URL") || "https://www.iebc.or.ke/registration/"

# Configure the endpoint
config :patakituo_backend, PatakituoBackendWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: PatakituoBackendWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: PatakituoBackend.PubSub,
  live_view: [signing_salt: "lhyJOfV8"]

# Configure Elixir's Logger
config :logger, :default_formatter,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :patakituo_backend, PatakituoBackendWeb.Auth.Guardian,
  issuer: "patakituo_backend",
  secret_key: System.get_env("GUARDIAN_SECRET_KEY") || "a very secret key"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
