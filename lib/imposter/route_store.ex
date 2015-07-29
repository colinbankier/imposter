defmodule Imposter.RouteStore do
  require Logger
  import Agent

  @agent __MODULE__

  def start_link do
    initial_state = %{}
    start_link fn -> initial_state end, name: @agent
  end

  def add_route(method, path, response) do
    update @agent, fn routes ->
      Dict.put_new(routes, {method, path}, response)
    end
  end

  def routes do
    get @agent, fn routes ->
      routes
      |> Dict.keys
      |> Enum.map(fn key = {method, path} ->
        %{
          method: method,
          path: path,
          response: Dict.fetch!(routes, key)
        }
      end)
    end
  end
end
