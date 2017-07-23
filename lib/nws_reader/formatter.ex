defmodule NwsReader.Formatter do
  @moduledoc """
  Makes data readable as text in a nice format.
  """

  def get_lengths(map) do
    Map.keys(map)
    |> Enum.max_by(fn(item) -> String.length(item) end)
    |> IO.inspect(label: "max of keys")
  end

  def format_divider({key_length, val_length}, divider_char \\ "-") do
    key_section = "#{String.duplicate(divider_char, key_length)}"
    val_section = "#{String.duplicate(divider_char, val_length)}"
    "#{divider_char}#{key_section}#{divider_char}#{val_section}#{divider_char}"
  end

  def format_key_value({key, value}, {key_length, val_length}, delimiter \\ "|") do
    key_padding = key_length - String.length(key)
    val_padding = val_length - String.length(value)
    key_formatted = "#{key}#{String.duplicate(" ", key_padding)}"
    val_formatted = "#{value}#{String.duplicate(" ", val_padding)}"
    "#{delimiter}#{key_formatted}#{delimiter}#{val_formatted}#{delimiter}"
  end

end