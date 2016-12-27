defmodule Lofa.Router do
  use Lofa.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Lofa.Auth, repo: Lofa.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Lofa do
    pipe_through :browser # Use the default browser stack

    resources "/users",     UserController,     only: [:index,  :show,    :new,     :create]
    get "/hello/:name",     HelloController,    :world
    resources "/sessions",  SessionController,  only: [:new,    :create,  :delete]
    get "/",                PageController,     :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Lofa do
  #   pipe_through :api
  # end
end
