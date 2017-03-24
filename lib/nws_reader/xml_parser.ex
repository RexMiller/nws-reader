defmodule NwsReader.XmlParser do
  
  @tag_pattern ~r{<([A-Z][A-Z0-9_]*)\b[^>]*>(.*?)</\1>}is

  def map_xml(xml) do
    @tag_pattern
    |> Regex.scan(xml, capture: :all_but_first)
    |> map_scanned([])
    |> Map.new()
  end

  defp map_scanned([], result), do: Enum.reverse(result)

  defp map_scanned([head|tail], result) do
    [tag|contents] = head
    [leaf|_] = contents

    if Regex.match?(@tag_pattern, leaf),
      do: map_scanned(tail, [{tag, Map.new(map_xml(leaf))} | result]),
      else: map_scanned(tail, [{tag, leaf} | result])
  end

end