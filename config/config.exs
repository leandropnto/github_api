# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :github_api,
  ecto_repos: [GithubApi.Repo]

# configuracao do banco para chave primaria e estrangeira
config :github_api, GithubApi.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Configuração da lib TESLA para request HTTP
config :tesla, adapter: Tesla.Adapter.Hackney

# Configures the endpoint
config :github_api, GithubApiWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: GithubApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: GithubApi.PubSub,
  live_view: [signing_salt: "ai+27ARc"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :github_api, GithubApi.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

# Guardian
# <- Deve ser o nome do módulo em que estamos configurando
config :github_api, GithubApiWeb.Auth.Guardian,
  issuer: "github_api",
  secret_key: "t8QWNl7nfkmEx3bXBpUNe7jJdxdoVqsVKwSMFywe8Tr6rdHaL01cugKonDnuKVHN"

config :github_api, GithubApiWeb.Auth.Pipeline,
  module: GithubApiWeb.Auth.Guardian,
  error_handler: GithubApiWeb.Auth.ErrorHandler
