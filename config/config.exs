# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :magic_link,
  ecto_repos: [MagicLink.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :magic_link, MagicLinkWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: MagicLinkWeb.ErrorHTML, json: MagicLinkWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: MagicLink.PubSub,
  live_view: [signing_salt: "yyxrouZK"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :magic_link, MagicLink.Mailer, adapter: Swoosh.Adapters.Local

# Basic auth configuration for admin routes
config :magic_link, :basic_auth, username: "admin@gmail.com", password: "qwe123qwe"

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.21.5",
  magic_link: [
    args:
      ~w(js/app.tsx --bundle --chunk-names=chunks/[name]-[hash] --splitting --format=esm  --target=es2020 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.3",
  magic_link: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configure the Inertia adapter
config :inertia,
  # The Phoenix Endpoint module for your application. This is used for building
  # asset URLs to compute a unique version hash to track when something has
  # changed (and a reload is required on the frontend).
  endpoint: MagicLinkWeb.Endpoint,

  # An optional list of static file paths to track for changes. You'll generally
  # want to include any JavaScript assets that may require a page refresh when
  # modified.
  static_paths: ["/assets/app.js"],

  # The default version string to use (if you decide not to track any static
  # assets using the `static_paths` config). Defaults to "1".
  default_version: "1",

  # Enable automatic conversion of prop keys from snake case (e.g. `inserted_at`),
  # which is conventional in Elixir, to camel case (e.g. `insertedAt`), which is
  # conventional in JavaScript. Defaults to `false`.
  camelize_props: false,

  # Instruct the client side whether to encrypt the page object in the window history
  # state. This can also be set/overridden on a per-request basis, using the `encrypt_history`
  # controller helper. Defaults to `false`.
  history: [encrypt: false],

  # Enable server-side rendering for page responses (requires some additional setup,
  # see instructions below). Defaults to `false`.
  ssr: false,

  # Whether to raise an exception when server-side rendering fails (only applies
  # when SSR is enabled). Defaults to `true`.
  #
  # Recommended: enable in non-production environments and disable in production,
  # so that SSR failures will not cause 500 errors (but instead will fallback to
  # CSR).
  raise_on_ssr_failure: config_env() != :prod

config :kaffy,
  # required keys
  # required
  otp_app: :magic_link,
  # required
  ecto_repo: MagicLink.Repo,
  # required
  router: MagicLinkWeb.Router,
  # optional keys
  admin_title: "MagicLink",
  admin_logo: [
    url: "/images/logo-full.png",
    style: "width:200px;height:66px;object-fit:contain;"
  ],
  admin_logo_mini: "/images/logo.png",
  hide_dashboard: true,
  home_page: [schema: [:accounts, :user]],
  # since v0.10.0
  enable_context_dashboards: true,
  # since v0.10.0
  admin_footer: "Kaffy &copy; 2025"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
