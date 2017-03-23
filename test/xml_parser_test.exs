defmodule NwsReader.XmlParserTest do
  use ExUnit.Case
  
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