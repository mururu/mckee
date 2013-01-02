defmodule Mckee.Mustache do
  import Mckee.Template

  def compile(name, keyword) do
    keyword = Mckee.Utils.to_keyword(keyword)
    { config, binary } = extract_config(read(name))
    html = render(binary, keyword)

    if config[:layout] do
      Mckee.Mustache.compile(config[:layout], [content: html, page: keyword[:page]]) /> to_binary
    else
      html /> to_binary
    end
  end

  defp render(binary, keyword) do
    :mustache.render(binary_to_list(binary), :dict.from_list(Mckee.Utils.flatten(keyword)))
  end

  defp read(name) when is_list(name) do
    read list_to_binary(name)
  end

  defp read(name) when is_binary(name) do
    File.read! path(name <> ".mustache")
  end

  defp path(file) do
    File.join(Mckee.layouts_path, file)
  end
end
