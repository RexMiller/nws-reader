defmodule NwsReader.Formatter do
  @moduledoc """
  Makes data readable as text in a nice format.
  """

  def format(map) do
    lengths = get_lengths(map)
    map
    |> Enum.map(fn(kv) -> format_key_value(kv, lengths) end)
    |> Enum.join(format_divider(lengths))
  end

  def get_lengths(map) do
    map 
    |> Enum.unzip()
    |> longest_strings()
  end

  defp longest_strings({key_list, val_list}),
    do: { longest_string(key_list), longest_string(val_list) }

  defp longest_string(list) do
    list
    |> Enum.map(&String.length/1)
    |> Enum.max()
  end

  def format_divider({key_length, val_length}, divider_char \\ "-") do
    key_section = "#{String.duplicate(divider_char, key_length)}"
    val_section = "#{String.duplicate(divider_char, val_length)}"
    "\n#{divider_char}#{key_section}#{divider_char}#{val_section}#{divider_char}\n"
  end

  def format_key_value({key, value}, {key_length, val_length}, delimiter \\ "|") do
    key_padding = key_length - String.length(key)
    val_padding = val_length - String.length(value)
    key_formatted = "#{key}#{String.duplicate(" ", key_padding)}"
    val_formatted = "#{value}#{String.duplicate(" ", val_padding)}"
    "#{delimiter}#{key_formatted}#{delimiter}#{val_formatted}#{delimiter}"
  end

end