defmodule SolarTest do
  use ExUnit.Case
  use Timex

  setup do
    # NOTE
    # This is an Elixir list of maps
    flares = [
      %{classification: :X, stations: 10, scale: 99,   date: Timex.iso_triplet({1859, 8, 29})},
      %{classification: :M, stations: 10, scale: 5.8,  date: Timex.iso_triplet({2015, 1, 12})},
      %{classification: :M, stations: 6,  scale: 1.2,  date: Timex.iso_triplet({2015, 2, 9})},
      %{classification: :C, stations: 6,  scale: 3.2,  date: Timex.iso_triplet({2015, 4, 18})},
      %{classification: :M, stations: 7,  scale: 83.6, date: Timex.iso_triplet({2015, 6, 23})},
      %{classification: :C, stations: 10, scale: 2.5,  date: Timex.iso_triplet({2015, 7, 4})},
      %{classification: :X, stations: 2,  scale: 72,   date: Timex.iso_triplet({2012, 7, 23})},
      %{classification: :X, stations: 4,  scale: 45,   date: Timex.iso_triplet({2003, 11, 4})},
    ]

    # NOTE
    # Like in other unit testing frameworks, setup is run before every
    # test in our module. But we have to make the data that we build
    # here available to our tests. We do that by returning a tuple
    # with :ok in the first position followed by a keyword list. Otherwise
    # we'll get an error.
    {:ok, data: flares}
  end

  test "We have 8 solar flares", %{data: flares} do
    assert length(flares) == 8
  end

  test "Go inside", %{data: flares} do
    d = Solar.no_eva(flares)
    assert length(d) == 3
  end

  test "Deadliest", %{data: flares} do
    d = Solar.deadliest(flares)
    assert d == 99000
  end

  test "The flare list", %{data: flares} do
    assert 3 == length(Solar.flare_list(flares))
  end

  test "total flare power using recursion", %{data: flares} do
    total = Solar.total_flare_power(flares)
    assert total == 216911.7
  end

  test "total flare power using enums", %{data: flares} do
    total = Solar.total_flare_power_enum(flares)
    assert total == 216911.7
  end

  test "a flare list with comprehensions", %{data: flares} do
    list = Solar.flare_list(flares)
    assert 3 == length(list)
  end

  test "a flare list with enums", %{data: flares} do
    list = Solar.flare_list_enums(flares)
    assert 8 == length(list)
  end

end
