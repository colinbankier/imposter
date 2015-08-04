defmodule Imposter.Router do
  use Imposter.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Imposter do
    pipe_through :api

    resources "/_routes", RoutesController
    delete "/_routes", RoutesController, :delete_all
    resources "/_request_history", RequestHistoryController
    delete "/_request_history", RequestHistoryController, :delete_all
    forward "/", RequestController, :handle_request
  end
end
