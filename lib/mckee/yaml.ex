defmodule Mckee.Yaml do
  def parse(binary) do
    {:ok, result} = :yaml.load(binary)
    result /> List.flatten /> Mckee.Utils.to_keyword
  end
end
