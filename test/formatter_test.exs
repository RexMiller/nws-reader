defmodule NwsReader.FormatterTest do
  
  use ExUnit.Case, async: true
  import NwsReader.Formatter

  test "format_key_value formats key and value with delimiter and spacing" do
    lengths = {1, 3}
    
    formatted = %{ "k" => "v" } 
    |> Enum.at(0) 
    |> format_key_value(lengths, "|") 

    expected = "|k|v  |"
    assert(expected == formatted)
  end

  test "format_divider result is content length plus delimiters" do
    lengths = {1, 3}
    divider = format_divider(lengths, "-")
    expected = "-------"
    assert(expected == divider)
  end

  test "get_lengths gets tuple of max key and value lengths" do
    
  end

  def nested_map() do
    %{
      "k0" => "v0", 
      "k1" => "v1", 
      "k2.0" => %{
        "k2.1" => "v2.1",
        "k2.2" => "v2.2"
      },
      "k3.0" => %{ 
        "k3.1" => %{ 
          "k3.2" => "v3.2",
          "k3.3" => "v3.3"
        } 
      }
    }
  end
  
end