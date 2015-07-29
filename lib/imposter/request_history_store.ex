defmodule Imposter.RequestHistoryStore do
  require Logger
  import Agent

  @agent __MODULE__

  def start_link do
    initial_state = []
    start_link fn -> initial_state end, name: @agent
  end

  def add_request(method, path, body) do
    update @agent, fn requests ->
      requests ++ [{method, path, body}]
    end
  end

  def get_at(index) do
    get @agent, fn requests ->
      Enum.at(requests, index) |> mapify
    end
  end

  def requests do
    get @agent, fn requests ->
      requests
      |> Enum.map(&mapify/1)
    end
  end

  def clear do
    update @agent, fn requests ->
      []
    end
  end

  def mapify {method, path, body} do
    %{
      method: method,
      path: path,
      body: body
    }
  end
end
