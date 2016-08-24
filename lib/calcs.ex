defmodule Calcs do

  def square_root(val), do: :math.sqrt(val)
  def squared(val),     do: :math.pow(val, 2)
  def cubed(val),       do: :math.pow(val, 3)

  # Reduce algorithm
  def sum_list([head | tail], accumulator) do
    sum_list(tail, head + accumulator)
  end

  def sum_list([], accumulator) do
    accumulator
  end

  # Map algorithm
  def double_list([head | tail]) do
    [head * 2 | double_list(tail)]
  end

  def double_list([]) do
    []
  end

end
