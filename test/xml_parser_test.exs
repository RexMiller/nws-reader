defmodule NwsReader.XmlParserTest do
  use ExUnit.Case, async: true
  alias NwsReader.XmlParser, as: Parser
  doctest NwsReader.XmlParser

  test "some stuff" do
    expected = %{
      "a" => "aaa", 
      "c" => %{
        "b" => "b1b1"
      }, 
      "d" => %{
        "b" => "b2b2", 
        "c" => "c2c2"
      }
    }    
    result = Parser.map_xml xml()
    assert expected == result
  end

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
end