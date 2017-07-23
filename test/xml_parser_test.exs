defmodule NwsReader.XmlParserTest do
  use ExUnit.Case, async: true
  alias NwsReader.XmlParser, as: Parser
  doctest NwsReader.XmlParser

  test "map_xml parses XML into a map data structure" do
    xml()
    |> Parser.map_xml()
    |> assert_equal(parsed_xml())
    
  end

  defp assert_equal(result, expected), do: assert(expected == result)

  defp xml do
    """
    <a>aaa</a>
    <c><b>b1b1</b></c>
    <d>
      <b>b2b2</b>
      <c>c2c2</c>
    </d>
    """    
  end

  defp parsed_xml do
    %{
      "a" => "aaa", 
      "c" => %{
        "b" => "b1b1"
      }, 
      "d" => %{
        "b" => "b2b2", 
        "c" => "c2c2"
      }
    }
  end
end