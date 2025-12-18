Postgrex.Types.define(
  PatakituoBackend.PostgresTypes,
  [Geo.PostGIS.Extension] ++ Ecto.Adapters.Postgres.extensions(),
  json: Jason
)
