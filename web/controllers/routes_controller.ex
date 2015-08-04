defmodule Imposter.RoutesController do
  use Imposter.Web, :controller
  alias Imposter.RouteStore
  alias Imposter.Response

  def index(conn, _params) do
    json conn, RouteStore.routes
  end

  def create(conn, params) do
    response = struct(Imposter.Response, atomify(params["response"]))
    RouteStore.add_route(params["method"], params["path"], response)
    json conn, %{
      method: params["method"],
      path: params["path"]
    }
  end

  def delete_all(conn, params) do
    RouteStore.clear(params["method"], params["path"])
    json conn, %{ ok: true }
  end

  defp atomify params do
    for {key, val} <- params, into: %{}, do: {String.to_atom(key), val}
  end
end
