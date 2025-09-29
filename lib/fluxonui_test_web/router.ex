defmodule FluxonUITestWeb.Router do
  use FluxonUITestWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {FluxonUITestWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FluxonUITestWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/todos", TodoLive.Index, :index
    live "/todos/new", TodoLive.Form, :new
    live "/todos/:id", TodoLive.Show, :show
    live "/todos/:id/edit", TodoLive.Form, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", FluxonUITestWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:fluxonui_test, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: FluxonUITestWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
