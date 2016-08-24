defmodule Physics.Rocketry do

  import Calcs, except: [addition: 0]
  import Converter
  import Physics.Laws, only: [gravitational_constant: 0]

  @earth Planet.select[:earth]

  def orbital_speed(height), do: orbital_speed(@earth, height)
  def orbital_speed(planet, height) do
    (gravitational_constant * planet.mass) / orbital_radius(planet, height)
      |> square_root
  end

  def orbital_acceleration(height), do: orbital_acceleration(@earth, height)
  def orbital_acceleration(planet, height) do
    (orbital_speed(planet, height) |> squared) / orbital_radius(planet, height)
  end

  def orbital_term(height), do: orbital_term(@earth, height)
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
    ((hours_to_seconds(hours) |> squared) * gravitational_constant * @earth.mass) /
    (4 * (:math.pi |> squared))
      |> Math.nth_root(3)
      |> Kernel.-(@earth.radius)
      |> to_km
      |> to_nearest_tenth
  end

  defp orbital_radius(planet, height) do
    planet.radius + (height |> to_meters)
  end

  # defp calculate_escape(%{mass: mass, radius: radius}) do
  #   ((2 * gravitational_constant * mass) / radius) |> :math.sqrt
  # end

end
