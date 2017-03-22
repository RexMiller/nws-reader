defmodule NwsReader.ClientTests do
  use ExUnit.Case
  doctest NwsReader.Client

  # test "get_stations returns list of stations for a valid US state" do
  #   stations = NwsReader.Client.get_stations("AZ")

  #   station_pattern = ~r/^\w{3,4}$/
  #   description_pattern = ~r/^[\w\s\-\,\'\/\.']+$/

  #   Enum.each stations, fn({station, desc}) -> 
  #     assert Regex.match?(station_pattern, station)
  #     assert Regex.match?(description_pattern, desc)
  #   end
  # end

  # test "get_stations returns empty for an unrecognized state" do
  #   stations = NwsReader.Client.get_stations("zz")

  #   assert Enum.any?(stations) == false
  # end

  # test "get_observation returns xml for a given station" do
  #   observation = NwsReader.Client.get_observation("kluf")
  #   IO.puts observation
  # end

  test "some stuff" do
    xml = """
	<credit>NOAA's National Weather Service</credit>
	<image>
		<url>http://weather.gov/images/xml_logo.gif</url>
		<link>http://weather.gov</link>
	</image>
	<weather>Fair</weather>
  <temp>
    comes in two flavors
    <temp_f>60</temp_f>
  </temp>
    """
    xml
    |> NwsReader.XmlParser.map_xml()
    |> IO.inspect(label: "\nResult")
  end

end

defmodule NwsReader.XmlParser do
  
  @tag_pattern ~r{<([A-Z][A-Z0-9_]*)\b[^>]*>(.*?)</\1>}is

  def map_xml(xml) do
    @tag_pattern
    |> Regex.scan(xml, capture: :all_but_first)
    |> IO.inspect(label: "\nscanned")
    |> map_scanned([])
    |> Map.new()
  end

  defp map_scanned([], result), do: Enum.reverse(result)

  defp map_scanned([head|tail], result) do
    [tag|contents] = head
    [leaf|_] = contents

    if Regex.match?(@tag_pattern, leaf),
      do: map_scanned(tail, [{tag, Map.new(map_xml(leaf))} | result]),
      else: map_scanned(tail, [{tag, leaf} | result])
  end

end