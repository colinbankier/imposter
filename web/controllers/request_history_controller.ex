defmodule Imposter.RequestHistoryController do
  use Imposter.Web, :controller
  alias Imposter.RequestHistoryStore

  def index(conn, _params) do
    json conn, RequestHistoryStore.requests
  end

  def show(conn, params) do
    {index, _} = Integer.parse params["id"]
    json conn, RequestHistoryStore.get_at(index)
  end

  def delete_all(conn, _params) do
    RequestHistoryStore.clear
    json conn, %{ ok: true }
  end
end
