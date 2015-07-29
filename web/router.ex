defmodule Imposter.Router do
  use Imposter.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Imposter do
    pipe_through :api

    get "/", PageController, :index
    resources "/_routes", RoutesController
    forward "/", RequestController, :handle_request
  end
end
