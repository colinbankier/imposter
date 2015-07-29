defmodule Imposter.RequestController do
  use Imposter.Web, :controller
  alias Imposter.RouteStore
  alias Imposter.RequestHistoryStore
  alias Imposter.Response

  def handle_request(conn, params) do
    RequestHistoryStore.add_request conn.method, conn.request_path, conn.body_params
    response = RouteStore.get_route(conn.method, conn.request_path)
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(response.status_code, response.body)
  end
end
