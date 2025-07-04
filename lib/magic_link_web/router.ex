defmodule MagicLinkWeb.Router do
  use MagicLinkWeb, :router

  import Plug.BasicAuth
  import MagicLinkWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {MagicLinkWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
    plug :put_user_token
    plug Inertia.Plug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :private_layout do
    plug :put_layout, html: {MagicLinkWeb.Layouts, :authenticated}
  end

  pipeline :admin_auth do
    plug :basic_auth, Application.compile_env(:magic_link, :basic_auth)
  end

  use Kaffy.Routes, scope: "/admin", pipe_through: [:admin_auth]

  scope "/", MagicLinkWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  # Other scopes may use custom stacks.
  # scope "/api", MagicLinkWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:magic_link, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: MagicLinkWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", MagicLinkWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      layout: {MagicLinkWeb.Layouts, :auth},
      on_mount: [{MagicLinkWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", MagicLinkWeb do
    pipe_through [:browser, :require_authenticated_user, :private_layout]

    live_session :require_authenticated_user,
      layout: {MagicLinkWeb.Layouts, :authenticated},
      on_mount: [{MagicLinkWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email
    end

    get "/links", LinkController, :index
    post "/links", LinkController, :create_link
    delete "/links/:id", LinkController, :delete_link

    post "/links/bio", LinkController, :create_bio_link
    patch "/links/bio/:id", LinkController, :update_bio_link
    delete "/links/bio/:id", LinkController, :delete_bio_link
  end

  scope "/", MagicLinkWeb do
    pipe_through [:browser]

    get "/l/:short_id", LinkResolverController, :show

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      layout: {MagicLinkWeb.Layouts, :auth},
      on_mount: [{MagicLinkWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end

  scope "/api", MagicLinkWeb do
    pipe_through [:api, :ensure_bearer_token]

    resources "/links", LinkControllerJSON
    resources "/bio_links", BioLinkControllerJSON
    resources "/external_links", ExternalLinkControllerJSON
  end
end
