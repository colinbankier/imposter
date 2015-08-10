defmodule Imposter.RoutesControllerTest do
  use Imposter.ConnCase

  @attrs %{method: "GET", path: "/baz", response: %{ body: %{foo: "this is a get"}}}

  setup do
    on_exit fn ->
      delete conn, request_history_path(conn, :delete_all)
      delete conn, routes_path(conn, :delete_all)
    end

    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, routes_path(conn, :index)
    assert conn.status == 200
    assert conn.resp_body == "[]"
  end

  test "lists an actual entry on index", %{conn: conn} do
    conn = post conn, routes_path(conn, :create), @attrs

    conn = get conn, routes_path(conn, :index)
    assert conn.status == 200
    assert conn.resp_body == "[{\"response\":{\"status_code\":200,\"headers\":[],\"body\":{\"foo\":\"this is a get\"}},\"path\":\"/baz\",\"method\":\"GET\"}]"
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, routes_path(conn, :create), @attrs
    assert conn.status == 200
    assert conn.resp_body == "{\"path\":\"/baz\",\"method\":\"GET\"}"
  end

  test "deletes all chosen resources", %{conn: conn} do
    conn = post conn, routes_path(conn, :create), @attrs

    conn = delete conn, routes_path(conn, :delete_all)
    conn = get conn, routes_path(conn, :index)
    assert conn.status == 200
    assert conn.resp_body == "[]"
  end
end
