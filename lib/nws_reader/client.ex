defmodule NwsReader.Client do
  @moduledoc """
  A simple Http client for http://w1.weather.gov.
  """

  @doc """
  Given a US state, gets a map of weather stations you can query.
  """
  def get_stations(for_state) do
    for_state
    |> String.downcase()
    |> build_station_query()
    |> HTTPoison.get!()
    |> parse_stations()
  end

  @doc """
  Given a weather station call sign, gets the weather observation XML for that station.
  """
  def get_observation(for_station) do
    for_station
    |> String.upcase()
    |> build_observation_query()
    |> HTTPoison.get!()
    |> parse_observation_response()
  end

  defp build_station_query(state) do
    "http://w1.weather.gov/xml/current_obs/seek.php?state=#{state}"
  end

  defp parse_stations(%{body: body}) do
    station_regex = ~r/\<a href\=\"display\.php\?stid\=(\w{4})\"\>(.+)\<\/a\>/
    body
    |> String.split("\n")
    |> Enum.reduce(%{}, fn(line, acc) -> 
         case Regex.scan(station_regex, line, capture: :all_but_first) do
            [[station, desc]] -> Map.put(acc, station, desc)
            [] -> acc 
         end
       end)
  end

  defp build_observation_query(station) do
    "http://w1.weather.gov/xml/current_obs/#{station}.xml"
  end

  defp parse_observation_response(%{body: body}) do
    body
  end
end