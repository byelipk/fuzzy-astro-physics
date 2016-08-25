defmodule Mix.Tasks.LoadFlares do
  use Mix.Task
  use Timex

  def run(_args) do
    flares = [
      %{classification: "M", stations: 10, scale: 99.0, date: Timex.iso_triplet({1859, 8, 29})},
      %{classification: "M", stations: 10, scale: 5.8,  date: Timex.iso_triplet({2015, 1, 12})},
      %{classification: "M", stations: 6,  scale: 1.2,  date: Timex.iso_triplet({2015, 2, 9})},
      %{classification: "C", stations: 6,  scale: 3.2,  date: Timex.iso_triplet({2015, 4, 18})},
      %{classification: "M", stations: 7,  scale: 83.6, date: Timex.iso_triplet({2015, 6, 23})},
      %{classification: "C", stations: 10, scale: 2.5,  date: Timex.iso_triplet({2015, 7, 4})},
      %{classification: "X", stations: 2,  scale: 72.0, date: Timex.iso_triplet({2012, 7, 23})},
      %{classification: "X", stations: 4,  scale: 45.0, date: Timex.iso_triplet({2003, 11, 4})},
    ]

    for flare <- flares, do: struct(Physics.SolarFlare, flare) |> Physics.Repo.insert!

  end
end
