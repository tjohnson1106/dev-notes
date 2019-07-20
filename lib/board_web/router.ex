defmodule BoardWeb.Router do
  use BoardWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BoardWeb do
    pipe_through :browser

    resources "/cards", CardController
    resources "/lists", ListController
    resources "/users", UserController
    resources "/comments", CommentController
    resources "/activities", ActivityController

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", BoardWeb do
  #   pipe_through :api
  # end
end
