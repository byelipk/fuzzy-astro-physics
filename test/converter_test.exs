defmodule ConverterTest do

  use ExUnit.Case
  doctest Converter

  test "Converting to to_light_seconds in miles works" do
    ls = Converter.to_light_seconds({:miles, 1000}, precision: 5)
    assert ls == 0.00537
  end

  test "Converting to_light_seconds in meters works" do
    ls = Converter.to_light_seconds({:meters, 1000}, precision: 10)
    assert ls == 3.3356e-6
  end

  test "Converting to_light_seconds in feet works" do
    ls = Converter.to_light_seconds({:feet, 10000000}, precision: 6)
    assert ls == 0.010167
  end

  test "Converting to_light_seconds in inches works" do
    ls = Converter.to_light_seconds({:inches, 150}, precision: 12)
    assert ls == 1.2709e-8
  end

  test "Converting meters to kilometers works" do
    ls = Converter.to_km(50000)
    assert ls == 50
  end

  test "Converting kilometers to meters works" do
    ls = Converter.to_meters(50)
    assert ls == 50000
  end

  test "Converting seconds to hours works" do
    ls = Converter.seconds_to_hours(1000000)
    assert ls == 277.8
  end

  test "Converting to nearest tenth works" do
    ls = Converter.to_nearest_tenth(12.3333333)
    assert ls == 12.3
  end

end
