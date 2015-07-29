defmodule Imposter.RequestController do
  use Imposter.Web, :controller
  alias Imposter.RouteStore
  alias Imposter.Response

  def handle_request(conn, params) do
    response = RouteStore.get_route(conn.method, conn.request_path)
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(response.status_code, response.body)
  end
end
