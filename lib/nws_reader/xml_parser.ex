defmodule NwsReader.XmlParser do
  @moduledoc """
  Parses an XML fragment string into a map.
  """

  @tag_pattern ~r{<([A-Z][A-Z0-9_]*)\b[^>]*>(.*?)</\1>}is

  @doc """
  Parses an XML fragment string into a map. Works for child nodes but not for nodes with content and children.

  ## Example
  iex> NwsReader.XmlParser.map_xml("<a>aaa</a><b>b0b0</b>")
  %{"a" => "aaa", "b" => "b0b0"}
  """
  def map_xml(xml) do
    @tag_pattern
    |> Regex.scan(xml, capture: :all_but_first)
    |> map_scanned([])
    |> Map.new()
  end

  defp map_scanned([], result), do: Enum.reverse(result)

  defp map_scanned([head | tail], result) do
    [tag | contents] = head
    [leaf | _] = contents

    if Regex.match?(@tag_pattern, leaf),
      do: map_scanned(tail, [{tag, Map.new(map_xml(leaf))} | result]),
      else: map_scanned(tail, [{tag, leaf} | result])
  end

end