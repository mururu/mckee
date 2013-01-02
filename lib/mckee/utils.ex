defmodule Mckee.Utils do
  def flatten(list) do
    do_flatten(list, [])
  end

  defp do_flatten([h|t], acc), do: do_flatten(h, acc) ++ do_flatten(t, acc)
  defp do_flatten([], _), do: []

  defp do_flatten({k, v}, acc) do
    if is_keyword(v) do
      do_flatten(v, acc ++ [k])
    else
      atom = binary_to_atom Enum.join( acc ++ [k], ".")
      [{atom,v}]
    end
  end

  defp is_keyword(list) when is_list(list), do: :lists.all(is_keyword_tuple(&1), list)
  defp is_keyword(_), do: false

  defp is_keyword_tuple({ x, _ }) when is_atom(x), do: true
  defp is_keyword_tuple(_), do: false

  def to_keyword([h|t]), do: [to_keyword(h)|to_keyword(t)]
  def to_keyword({key, [{k, v}|t]}), do: { binary_to_atom(to_binary(key)), to_keyword([{k, v}|t])}
  def to_keyword({key, value}), do: { binary_to_atom(to_binary(key)), binary_to_list(to_binary(value)) }
  def to_keyword(rest), do: rest
end
