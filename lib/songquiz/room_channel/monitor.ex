defmodule Songquiz.RoomChannel.Monitor do
  use Agent
  def start_link(rooms) do
    Agent.start_link(fn -> rooms end, name: __MODULE__)
  end

  def get_room(code) do
    Agent.get(__MODULE__, fn rooms -> rooms[code] end)
  end

  def set_room(code, room) do
    Agent.update(__MODULE__, fn rooms -> Map.put(rooms, code, room) end)
  end

end
