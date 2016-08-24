defmodule RocketryTest do

  use ExUnit.Case
  import Physics.Rocketry

  test "Orbital speed for earth at 400km" do
    ls = orbital_speed(400) |> Converter.to_nearest_tenth
    assert ls == 7670.6
  end

  test "Orbital acceleration for earth at 100km" do
    orbital_acc = orbital_acceleration(100)
    assert orbital_acc == 9.515619587729839
  end

  test "Orbital height above earth for duration of 4 hours" do
    height = orbital_height_for_duration_of(4.0)
    assert height == 6420.0
  end

  test "Orbital term for 100km above earth" do
    term = orbital_term(100)
    assert term == 1.4
  end

  test "Orbital acceleration for Jupiter at 100km" do
    x = orbital_acceleration(Planet.select[:jupiter], 100)
    assert x == 24.659005330334
  end

  test "Orbital term at 100km for Saturn at 6000km" do
    x = orbital_term(Planet.select[:saturn], 6000)
    assert x == 4.8
  end

end
