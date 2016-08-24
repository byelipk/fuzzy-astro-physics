#This module needs to be a struct using this data:

# "Mercury", type: :rocky, mass: 3.3e23, radius: 2.439e6
# "Venus", type: :rocky, mass: 4.86e24, radius: 6.05e6
# "Earth", type: :rocky, mass: 5.972e24, radius: 6.37e6
# "Mars", type: :rocky, mass: 6.41e23, radius: 3.37e6
# "Jupiter", type: :gaseous, mass: 1.89e27, radius: 7.14e7
# "Saturn", type: :gaseous, mass: 5.68e26, radius: 6.02e7
# "Uranus", type: :gaseous, mass: 8.68e25, radius: 2.55e7
# "Neptune", type: :gaseous, mass: 1.02e26, radius: 2.47e7

# I need this put into a struct that defines the above fields *as well as*
# Escape Velocity, which we'll be calculating on the fly.

# After the struct is created, please create a function called `load`
# that returns all the planets *as well as* sets the Escape Velocity (`ev`)
# on each planet's struct. Extra points if you use a comprehension.

# Finally, I want each planet to be accessible with a key: earth = Planet.select[:earth]

defmodule Planets do

  import Planet

  # The planets
  def mars,  do: %{ mass: 6.39e23,          radius: 3.39e6  }
  def moon,  do: %{ mass: 7.34767309e22,    radius: 1.737e6 }
  def earth, do: %{ mass: 5.972e24,         radius: 6.371e6 }
  def venus, do: %{ mass: 4.867e24,         radius: 6.052e6 }

  def repo do
    [
      %{name: "Mercury", type: :rocky,   mass: 3.3e23,   radius: 2.439e6},
      %{name: "Venus",   type: :rocky,   mass: 4.86e24,  radius: 6.05e6},
      %{name: "Earth",   type: :rocky,   mass: 5.972e24, radius: 6.37e6},
      %{name: "Mars",    type: :rocky,   mass: 6.41e23,  radius: 3.37e6},
      %{name: "Jupiter", type: :gaseous, mass: 1.89e27,  radius: 7.14e7},
      %{name: "Saturn",  type: :gaseous, mass: 5.68e26,  radius: 6.02e7},
      %{name: "Uranus",  type: :gaseous, mass: 8.68e25,  radius: 2.55e7},
      %{name: "Neptune", type: :gaseous, mass: 1.02e26,  radius: 2.47e7}
    ]
  end

  def load do
    for planet <- repo,
      do: %Planet{
        name:   planet.name,
        type:   planet.type,
        radius: planet.radius,
        mass:   planet.mass,
        ev:     Physics.Rocketry.escape_velocity(planet)
      }
  end

  def select(name) when is_atom(name) do
    query = (to_string(name) |> String.capitalize)
    load |> Enum.find(fn(planet) -> planet.name == query end)
  end
end
