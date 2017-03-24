defmodule NwsReader.XmlParserTest do
  use ExUnit.Case
  
  test "some stuff" do
    xml = """
    <a>aaa</a>
    <b>b0b0</b>
    <c><b>b1b1</b></c>
    """
    result = NwsReader.XmlParser.map_xml(xml)
    expected = %{"a" => "aaa", "b" => "b0b0", "c" => %{"b" => "b1b1"}}
    assert expected == result
  end

end