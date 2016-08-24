defmodule Converter do

    def to_light_seconds({:miles, miles}, precision: precision) when is_integer(miles) or is_float(miles) do
      (miles * 5.36819e-6)
        |> round_to(precision)
    end

    def to_light_seconds({:meters, meters}, precision: precision) when is_integer(meters) or is_float(meters)  do
      (meters * 3.335638620368e-9)
        |> round_to(precision)
    end

    def to_light_seconds({:feet, feet}, precision: precision) when is_integer(feet) or is_float(feet)  do
      (feet * 1.016702651488166404e-9)
        |> round_to(precision)
    end

    def to_light_seconds({:inches, inches}, precision: precision) when is_integer(inches) or is_float(inches)  do
      (inches * 8.472522095734715723e-11)
        |> round_to(precision)
    end

    defp round_to(val, precision) when is_float(val) do
      Float.round(val, precision)
    end

    def to_km(meters) when is_integer(meters) or is_float(meters) do
      meters / 1000
    end

    def to_meters(km) when is_integer(km) or is_float(km) do
      # NOTE 1km = 1000m
      (km * 1000) / 1
    end

    def seconds_to_hours(seconds)  when is_integer(seconds) or is_float(seconds) do
      seconds / 3600 |> to_nearest_tenth
    end

    def hours_to_seconds(hours) when is_integer(hours) or is_float(hours) do
      # NOTE  1 hours = 3600 seconds
      (hours * 3600) / 1
    end

    def to_nearest_tenth(val) when is_integer(val) or is_float(val) do
      round_to(val, 1)
    end

end
