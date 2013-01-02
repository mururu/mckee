defmodule Mckee.Template do
  def extract_config(template) do
    { yaml, binary } = split(template, false, "")
    config = Mckee.Yaml.parse yaml
    { config, binary }
  end

  defp split(<< "---\n", rest :: binary >>, false, acc) do
    split(rest, true, acc)
  end

  defp split(<< "---\n", rest :: binary >>, true, acc) do
    {acc, rest}
  end

  defp split(_, false, _) do
    raise 'failed split'
  end

  defp split("", true, _) do
    raise "missing \"---\""
  end

  defp split(binary, true, acc) do
    [ head | tail ] = String.split(binary, "\n")
    split(Enum.join(tail, "\n"), true, acc <> "\n" <> head)
  end
end
