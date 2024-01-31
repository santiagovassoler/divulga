# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :divulga_io,
  ecto_repos: [DivulgaIo.Repo]

config :ecto_shorts,
  repo: DivulgaIo.Repo,
  error_module: EctoShorts.Actions.Error

# Get API from dashboard
config :divulga_io,
  studio_onea_api_key: "CHANGE_ME"

# Use OneaiService for AI text summarization
config :divulga_io, :ai_service, DivulgaIo.StudioOnea.OneaiService

# Configures the endpoint
config :divulga_io, DivulgaIoWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: DivulgaIoWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: DivulgaIo.PubSub,
  live_view: [signing_salt: "HjksbsPr"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :divulga_io, DivulgaIo.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
