defmodule NwsReader.MapFlattenerTest do
  
  use ExUnit.Case, async: true
  import NwsReader.MapFlattener

  test "flatten_children flattens sub-maps into formatted strings" do
    nested_map()
    |> flatten_children()
    |> assert_equal(flattened_map())
  end

  def assert_equal(result, expected), do: assert(expected == result)

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

  def flattened_map() do
    %{
      "k0" => "v0", 
      "k1" => "v1", 
      "k2.0" => "k2.1:v2.1, k2.2:v2.2",
      "k3.0" => "k3.1: k3.2:v3.2, k3.3:v3.3"
    }    
  end
end