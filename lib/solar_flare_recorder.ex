defmodule SolarFlareRecorder do

  use GenServer

  # Bind the current module to a process id with an empty
  # list as its initial state.
  def start_link do
    Agent.start_link fn -> [] end
  end

  def record_flare(pid, { :flare, classification: _, scale: _ } = flare) do
    Agent.get_and_update pid, fn(flares) ->
      new_state = List.insert_at flares, -1, flare
      {:ok, new_state}
    end
  end

  def get_flares(pid) do
    Agent.get pid, fn(flares) -> flares end
  end

end
