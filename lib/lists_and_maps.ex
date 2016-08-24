defmodule ListsAndMaps do

  def keyword_list do
    [
      [name: :mercury, type: :rocky,   ev: 4.3],
      [name: :venus,   type: :rocky,   ev: 10.4],
      [name: :earth,   type: :rocky,   ev: 11.2],
      [name: :mars,    type: :rocky,   ev: 5.0],
      [name: :jupiter, type: :gaseous, ev: 59.5],
      [name: :saturn,  type: :gaseous, ev: 35.5],
      [name: :uranus,  type: :gaseous, ev: 21.3],
      [name: :neptune, type: :gaseous, ev: 23.5]
    ]
  end

  def list_map do
    [
      %{name: "Mercury", type: :rocky,   ev: 4.3},
      %{name: "Venus",   type: :rocky,   ev: 10.4},
      %{name: "Earth",   type: :rocky,   ev: 11.2},
      %{name: "Mars",    type: :rocky,   ev: 5.0},
      %{name: "Jupiter", type: :gaseous, ev: 59.5},
      %{name: "Saturn",  type: :gaseous, ev: 35.5},
      %{name: "Uranus",  type: :gaseous, ev: 21.3},
      %{name: "Neptune", type: :gaseous, ev: 23.5}
    ]
  end

  def list_atoms do
    [
      :mercury,
      :venus,
      :earth,
      :mars,
      :jupiter,
      :saturn,
      :uranus
    ]
  end

  def find_enum(list) do
    Enum.find(list, fn ([name: n, type: _, ev: _]) -> n == :mars end)
  end

  def filter_enum(list) do
    Enum.filter(list, fn ([name: _, type: _, ev: ev]) -> ev > 10 end)
  end

  def count_planets(planets), do: count_planets(planets, 0)
  def count_planets([_ | tail], n), do: count_planets(tail, n + 1)
  def count_planets([], count), do: count
end
