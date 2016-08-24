defmodule Solar do

  def power(%{classification: :M, scale: s}), do: s * 10
  def power(%{classification: :X, scale: s, stations: c}) when c >= 5, do: s * 1000
  def power(%{classification: :X, scale: s, stations: c}) when c < 5,  do: s * 1000 * 1.1
  def power(%{classification: :C, scale: s}), do: s * 1

  def no_eva(flares), do: Enum.filter flares, &(power(&1) > 1000)

  def deadliest(flares) do
    Enum.map(flares, &(power(&1)))
      |> Enum.max
  end

  # NOTE
  # We need to create a set of functions using head | tail
  # recursion that sum the total flare power.
  #
  # Step 1 - Create a function head
  # Step 2 - Create function that accepts an accumulator
  # Step 3 - Handle the case of an empty list
  #
  # Here's the implementation:
  def total_flare_power(list), do: total_flare_power list, 0
  def total_flare_power([], total), do: total
  def total_flare_power([head | tail], total) do
    total_flare_power(tail, power(head) + total)
  end

  # NOTE
  # Here is an implementation using the for comprehension
  # def total_flare_power(list) do
  #   (for flare <- list, do: power(flare)) |> Enum.sum
  # end

  # def total_flare_power([%{classification: :M, scale: s} | tail], total) do
  #   new_total = power(s) * 0.92 + total
  #   total_flare_power(tail, new_total)
  # end
  #
  # def total_flare_power([%{classification: :C, scale: s} | tail], total) do
  #   new_total = power(s) * 0.72 + total
  #   total_flare_power(tail, new_total)
  # end
  #
  # def total_flare_power([%{classification: :X, scale: s} | tail], total) do
  #   new_total = power(s) * 0.68 + total
  #   total_flare_power(tail, new_total)
  # end

  # NOTE
  # We could also use Enum.reduce if all we need to do
  # is sum the values of a list.
  def total_flare_power_enum(list) do
    Enum.reduce list, 0, fn (flare, total) ->
      total + power(flare)
    end
  end

  # NOTE
  # This might be overkill since we could accomplish the same
  # task with Enum.map, but it is enjoyable to write!
  def flare_list(flares) do
    for flare     <- flares,
        power     <- [power(flare)],
        is_deadly <- [power > 1000],
        class     <- [flare.classification],

        # conditions
        class != :X and class != :C,
        class == :M,

        do: %{class: class, power: power, is_deadly: is_deadly}
  end

  def flare_list_enums(flares) do
    Enum.map flares, fn(flare) ->
      p = power(flare)
      %{power: p, is_deadly: p > 1000}
    end
  end

end
