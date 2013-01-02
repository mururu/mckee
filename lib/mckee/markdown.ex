defmodule Mckee.Markdown do
  import Mckee.Template

  def compile(path) do
    { config, binary } = extract_config(read(path))
    md_html = Markdown.to_html(binary)

    html =
      if config[:layout] do
        page_params = config /> Keyword.delete(:layout) /> Keyword.delete(:path)
        Mckee.Mustache.compile(config[:layout], [content: md_html, page: Keyword.delete(config, :layout)])
      else
        md_html
      end

    route =
      if config[:path] do
        config[:path]
      else
        File.rootname relative(path), ".md"
      end

    { route, html }
  end

  def relative(path) do
    i = String.length(Mckee.pages_path)
    String.slice(path, i, String.length(path) - i)
  end

  defp read(name) when is_list(name) do
    read list_to_binary(name)
  end

  defp read(path) do
    File.read! path
  end
end
