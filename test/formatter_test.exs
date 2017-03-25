defmodule NwsReader.FormatterTest do
  
  use ExUnit.Case, async: true
  import NwsReader.Formatter

  test "get_columns makes list of column values" do
    expected = [
      ["k0", "k1", "k2", "k3"],
      ["v0", "v1",
        [
          ["k2-0", "k2-1"], 
          ["v2-0", "v2-1"]
        ],
        [
          ["k3-0"], 
          ["v3-0"]
        ]
      ]
    ]
    col_data = get_columns data()
    assert expected == col_data
  end

  test "columns_to_rows renders column data as rows" do
    col_data = get_columns data()
    rows = columns_to_rows(col_data, "|")
    expected = [
      "k0|v0", 
      "k1|v1", 
      "k2|k2-0: v2-0, k2-1: v2-1", 
      "k3|k3-0: v3-0"
    ]
    assert expected == rows
  end

  defp data do
    %{
      "k0" => "v0", 
      "k1" => "v1", 
      "k2" => %{
        "k2-0" => "v2-0",
        "k2-1" => "v2-1"
      },
      "k3" => %{"k3-0" => "v3-0"}
    }
  end

end