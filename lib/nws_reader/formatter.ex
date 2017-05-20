defmodule NwsReader.Formatter do

  def print_map(map, delimiter \\"|") do
    #IO.inspect(map, label: "map")

    map
    |> Enum.map(&key_value_list/1)
    |> IO.inspect(label: "key_value_list")
  end

  defp key_value_list({key, value}) when is_map(value) do 
    IO.inspect {key, value}, label: "value is a sub-map"
    [key, print_map(value)]
  end
  
  defp key_value_list({key, value}) do 
    IO.inspect {key, value}, label: "value is scalar"
    [key, value]
  end

  defp key_value_list(value) do
    IO.inspect value, label: "dangling value with no key"
    ["no-key", value]
  end

end