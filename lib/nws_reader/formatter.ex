defmodule NwsReader.Formatter do
  
  def get_columns(map) do
    [ 
      Map.keys(map), 
      map 
      |> Map.values() 
      |> Enum.map(&get_column_contents/1)
    ]
  end

  def columns_to_rows(col_data, delimiter \\" | ") do
    col_data
    |> List.zip()
    |> Enum.map(fn(row) -> render_row(row, delimiter) end)
  end

  def render_row(row) when is_list(row) do
    Enum.join(row, ", ")
  end

  def render_row(row_tuple, delimiter \\" | ") do
    row_tuple
    |> Tuple.to_list()
    |> Enum.map(&render_column/1)
    |> Enum.join(delimiter)
  end

  defp get_column_contents(col) when is_map(col), do: get_columns col
  defp get_column_contents(col), do: "#{col}"

  defp render_column(value) when is_list(value) do
    value
    |> columns_to_rows(" - ")
    |> render_row()
  end

  defp render_column(value), do: value

end