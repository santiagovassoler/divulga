# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :divulga,
  ecto_repos: [Divulga.Repo]

# Configures the endpoint
config :divulga, DivulgaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "GCPpm1T1J+TStkPaHvOisZUAdgGvATW/Bomxv+Kj+Pe6oJS6eBSSvGrjDRf84NJR",
  render_errors: [view: DivulgaWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Divulga.PubSub,
  live_view: [signing_salt: "xUa/Q3ug"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Guardian config details
config :divulga, Divulga.Guardian,
  issuer: "divulga",
  secret_key: "Nn1zVAK667nzvlMJfDfIA+dUT3NoykHwa6YWT1LP1yYGIXISx9zLXmYrKCSUDiS0"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
