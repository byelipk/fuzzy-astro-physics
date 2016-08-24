defmodule Recursion do

  def say(msg, n) when n < 1 do
    IO.puts(msg)
  end

  def say(msg, n) do
    IO.puts(msg)
    say(msg, n - 1)
  end

end
