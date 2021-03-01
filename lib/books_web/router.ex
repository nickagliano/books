defmodule BooksWeb.Router do
  use BooksWeb, :router
  # test
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {BooksWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BooksWeb do
    pipe_through :browser

    # pages
    live "/", PageLive, :index
    live "/pages", PageLive.Index, :index
    live "/pages/new", PageLive.Index, :new
    live "/pages/:id/edit", PageLive.Index, :edit
    live "/pages/:id", PageLive.Show, :show
    live "/pages/:id/show/edit", PageLive.Show, :edit

    # passive abilities
    live "/passive_abilities", PassiveAbilityLive.Index, :index
    live "/passive_abilities/new", PassiveAbilityLive.Index, :new
    live "/passive_abilities/:id/edit", PassiveAbilityLive.Index, :edit
    live "/passive_abilities/:id", PassiveAbilityLive.Show, :show
    live "/passive_abilities/:id/show/edit", PassiveAbilityLive.Show, :edit

    
  end

  # Other scopes may use custom stacks.
  # scope "/api", BooksWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: BooksWeb.Telemetry
    end
  end
end
