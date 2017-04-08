defmodule NwsReader.Formatter do

  def print_map

  def print_map(map, delimiter \\"|") do
    IO.inspect(map, label: "map")

    map
    |> Enum.map(&key_value_list/1)
    |> Enum.map(&format_key_value_list/1)
  end

  defp key_value_list({key, value}) when is_map(value), do: [key, print_map(value)]
  defp key_value_list({key, value}), do: [key, value]

  defp format_key_value_list([key, value]) when is_list(value) do
     "#{key} , #{print_map(value)}"
  end

  defp format_key_value_list([key, value]) do
     "#{key} | #{value}"
  end

  defp format_pair({key, value}, delimiter) when is_map(value) do
    "#{key}#{delimiter}#{print_map(value, ": ")}"    
  end

  defp format_pair({key, value}, delimiter) do
    "#{key}#{delimiter}#{value}"
  end


  def get_columns(map) do
    [ 
      Map.keys(map), 
      map 
      |> Map.values() 
      |> Enum.map(&get_column_contents/1)
    ]
  end

  def columns_to_rows(col_data, delimiter) do
    col_data
    |> List.zip()
    |> IO.inspect(label: "col_data zipped for delimiter(#{delimiter})")
    |> Enum.map(fn(row) -> render_pair(row, delimiter) end)
  end

  def render_pair(row, delimiter) when is_list(row) do
    IO.inspect(row, label: "render_pair() |> Enum.join(#{delimiter})")
    Enum.join(row, delimiter)
  end

  def render_pair(key_value_tuple, delimiter) do
    key_value_tuple
    |> Tuple.to_list()
    |> Enum.map(&render_column/1)
    |> Enum.join(delimiter)
  end

  defp get_column_contents(col) when is_map(col), do: get_columns col
  defp get_column_contents(col), do: "#{col}"

  defp render_column(value) when is_list(value) do
    IO.inspect(value, label: "columns_to_rows")
    value
    |> columns_to_rows(": ")
    |> render_pair(", ")
  end

  defp render_column(value, pad_char \\" ", width \\0) do
    padding = Kernel.max(width - String.length(value), 0)
    "#{value}#{String.duplicate(pad_char, padding)}"
  end

end