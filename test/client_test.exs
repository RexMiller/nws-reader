defmodule NwsReader.ClientTests do
  use ExUnit.Case
  doctest NwsReader.Client

  test "get_stations returns list of stations for a valid US state" do
    stations = NwsReader.Client.get_stations("AZ")

    station_pattern = ~r/^\w{3,4}$/
    description_pattern = ~r/^[\w\s\-\,\'\/\.']+$/

    Enum.each stations, fn({station, desc}) -> 
      assert Regex.match?(station_pattern, station)
      assert Regex.match?(description_pattern, desc)
    end
  end

  test "get_stations returns empty for an unrecognized state" do
    stations = NwsReader.Client.get_stations("zz")

    assert Enum.any?(stations) == false
  end

  test "get_observation returns xml for a given station" do
    observation = NwsReader.Client.get_observation("kluf")
    IO.puts observation
  end

end