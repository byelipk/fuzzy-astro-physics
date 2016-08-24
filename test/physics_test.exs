defmodule PhysicsTest do
  use ExUnit.Case
  import Physics.Rocketry
  doctest Physics

  test "escape velocity of earth is correct" do
    ev = escape_velocity :earth
    assert ev == 11.2
  end

  test "escape velocity of planet mars is correct" do
    ev = escape_velocity :mars
    assert ev == 5.0
  end

  test "escape velocity of planet venus is correct" do
    ev = escape_velocity :venus
    assert ev == 10.4
  end

  test "escape velocity of the moon is correct" do
    ev = escape_velocity :moon
    assert ev == 2.4
  end

  test "escape velocity of planet x is correct" do
    ev = %{mass: 4.0e22, radius: 6.21e6}
      |> escape_velocity

    assert ev == 0.9
  end

end
