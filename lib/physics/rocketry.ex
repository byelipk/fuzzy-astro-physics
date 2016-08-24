# Let's remove all of the extra functions for `:earth`, `:moon` and `:mars` - we don't need them.
# Instead, define a default planet at the top of the module; use `@earth` and
# reference your `Planet.select[:earth]` structure.

# Anything else you see that you think you can improve, have at it. **The goal is clarity and elegance** so we can build this out.

# I've been waiting on a data drop from the Science Team and I think we'll be all set soon for working with PostgreSQL. That'll be fun.


defmodule Physics.Rocketry do

  import Calcs, except: [addition: 0]
  import Converter
  import Physics.Laws, only: [gravitational_constant: 0]
  import Planets

  def escape_velocity(:mars),  do: mars  |> escape_velocity
  def escape_velocity(:moon),  do: moon  |> escape_velocity
  def escape_velocity(:earth), do: earth |> escape_velocity
  def escape_velocity(:venus), do: venus |> escape_velocity


  # NOTE
  # The escape velocity is the minimum velocity required to leave
  # a planet or moon. For a rocket or other object to leave a planet,
  # it must overcome the pull of gravity. The formula for escape
  # velocity contains a constant, G, which is called the "universal
  # gravitational constant". Its value is 6.673e-11. The unit for escape
  # velocity is meters per second (m/s).
  #
  # escape velocity = SQRT(
  #  2 * (gravitational constant)(mass of the planet or moon) /
  #      (radius of planet or moon)
  #  )
  #
  # escape velocity = SQRT(2GM / R)
  #
  # G = gravitational constant
  # M = mass of planet or moon in kg
  # R = radius of planet or moon in meters
  #
  def escape_velocity(planet) when is_map(planet) do
    planet
      |> calculate_escape
      |> to_km
      |> to_nearest_tenth
  end

  # NOTE
  # Objects that travel in uniform circular motion around the Earth
  # are said to be "in orbit". The velocity of this orbit depends on
  # the distance from the object to the center of the Earth. The
  # velocity has to be just right, so that the distance to the center
  # of the Earth is always the same.
  #
  # orbital velocity = SQRT(
  #   (gavitational constant) * (mass of earth) /
  #   (distance from object to center of the earth)
  # )
  #
  # v = SQRT(GMe / r)
  #
  # v  = orbital velocity of an object in meters per second (m/s)
  # G  = gravitational constant
  # Me = mass of the earth
  # r  = distance of object to center of the earth
  #
  def orbital_speed(height), do: orbital_speed(earth, height)
  def orbital_speed(planet, height) do
    (gravitational_constant * planet.mass) / orbital_radius(planet, height)
      |> square_root
  end

  def orbital_acceleration(height), do: orbital_acceleration(earth, height)
  def orbital_acceleration(planet, height) do
    (orbital_speed(planet, height) |> squared) / orbital_radius(planet, height)
  end

  # NOTE
  # The orbital period is the time taken for a given object to make
  # one complete orbit around another object.
  # T = SQRT(4 * pi^2 * radius^3 / newton * mass)
  #
  def orbital_term(height), do: orbital_term(earth, height)
  def orbital_term(planet, height) do
    4 * (:math.pi |> squared) * (orbital_radius(planet, height) |> cubed) /
      (gravitational_constant * planet.mass)
      |> square_root
      |> seconds_to_hours
  end

  # NOTE
  # The goal is to find the height in meters if for an
  # acceptable orbital term. This function will calculate
  # the correct height for T hours.
  #
  # r = NthRoot(3) { G * M * T^2 / 4 * pi^2 }
  #
  # See: http://www.dummies.com/how-to/content/how-to-calculate-the-period-and-orbiting-radius-of.html
  def orbital_height_for_duration_of(hours) do
    ((hours_to_seconds(hours) |> squared) * gravitational_constant * earth.mass) /
    (4 * (:math.pi |> squared))
      |> Math.nth_root(3)
      |> Kernel.-(earth.radius)
      |> to_km
      |> to_nearest_tenth
  end

  defp orbital_radius(planet, height) do
    planet.radius + (height |> to_meters)
  end

  defp calculate_escape(%{mass: mass, radius: radius}) do
    ((2 * gravitational_constant * mass) / radius) |> :math.sqrt
  end

end
