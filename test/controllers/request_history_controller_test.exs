defmodule Imposter.RequestHistoryControllerTest do
	use Imposter.ConnCase

	alias Imposter.RequestHistory

	@attrs %{method: "GET", path: "/baz", response: %{foo: "this is a get"}}

	setup do
		conn = conn() |> put_req_header("accept", "application/json")
		{:ok, conn: conn}
	end

	test "lists all entries on index", %{conn: conn} do
		conn = get conn, request_history_path(conn, :index)
    assert conn.status == 200
    assert conn.resp_body == "[]"
	end

	test "shows chosen resource", %{conn: conn} do
	  conn = post conn, routes_path(conn, :create), @attrs
	  conn = get conn, "/baz"
	  conn = get conn, request_history_path(conn, :show, 0)
  	assert conn.status == 200
  	assert conn.resp_body == "{\"path\":\"/baz\",\"method\":\"GET\",\"body\":{}}"
  	conn = delete conn, request_history_path(conn, :delete_all)
  	conn = delete conn, routes_path(conn, :delete_all)
  end

	test "deletes all chosen resources", %{conn: conn} do
		conn = post conn, routes_path(conn, :create), @attrs
	  conn = get conn, "/baz"
		conn = delete conn, request_history_path(conn, :delete_all)
  	assert conn.status == 200
		conn = delete conn, routes_path(conn, :delete_all)
  end
end
