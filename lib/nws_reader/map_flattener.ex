
defmodule NwsReader.MapFlattener do
  @moduledoc """
  Flattens nested map nodes as concatenated strings 
  """

  @doc """
  Flattens any values that are nested maps as string representations
  """
  def flatten_children(map) do
    Enum.reduce(map, %{}, 
      fn({k, v}, result) -> 
        append_key_value(result, k, v) 
      end
    )
  end

  defp append_key_value(result, key, value) when is_map(value) do
    Map.put(result, key, flatten_sub_map(value))
  end

  defp append_key_value(result, key, value) do
    Map.put(result, key, value)
  end

  defp flatten_sub_map(sub_map) do
    sub_map 
    |> Enum.map(fn({k, v}) -> format_sub_map(k, v) end)
    |> Enum.join(", ")
  end

  defp format_sub_map(key, value) when is_map(value) do
    "#{key}: #{flatten_sub_map(value)}"
  end

  defp format_sub_map(key, value) do
    "#{key}:#{value}"
  end
end