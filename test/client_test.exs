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
    <temperature_string>88.0 F (31.1 C)</temperature_string>
    <temp_f>88.0</temp_f>
    <temp_c>31.1</temp_c>
    <parent><child>child content</child></parent>
    <relative_humidity>14</relative_humidity>
    <pressure_string>1013.2 mb</pressure_string>
    <pressure_mb>1013.2</pressure_mb>
    <pressure_in>29.97</pressure_in>
    <dewpoint_string>33.1 F (0.6 C)</dewpoint_string>
    <dewpoint_f>33.1</dewpoint_f>
    <dewpoint_c>0.6</dewpoint_c>
    """
    xml
    |> NwsReader.XmlParser.scan()
    |> IO.inspect(label: "\nResult")
  end

  def xml_to_map(xml) do
    re = ~r{<([A-Z][A-Z0-9_]*)\b[^>]*>(.*?)</\1>}i
    re
    |> Regex.scan(xml, capture: :all_but_first) 
    |> Enum.map(fn([hd|tl]) ->
      [leaf|_] = tl
      if Regex.match?(re, leaf),
        do: {hd, xml_to_map(leaf)},
        else: {hd, leaf}
    end)   
  end
end

defmodule NwsReader.XmlParser do
  
  @regex ~r{<([A-Z][A-Z0-9_]*)\b[^>]*>(.*?)</\1>}i

  def scan(xml) do
    @regex
    |> Regex.scan(xml, capture: :all_but_first)
    |> IO.inspect(label: "\nscanned")
    |> Enum.map(fn(tag) -> 
      process_scanned(tag) 

    end)
  end

  defp process_scanned([node|contents]) do 
    [leaf | _] = contents
    {node, leaf}
  end

end