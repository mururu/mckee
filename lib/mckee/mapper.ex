defmodule Mckee.Mapper do
  defmacro __using__(_) do
    paths = find_page_paths
    Enum.map paths, fn(path)->
      { route, html } = Mckee.Markdown.compile(path)
      Code.string_to_ast! """
        get "#{route}" do
          conn.resp_body "#{html}"
        end
      """
    end
  end

  def find_page_paths do
    List.flatten do_find_page_paths(Mckee.pages_path)
  end

  defp do_find_page_paths(path) do
    Enum.map File.wildcard(File.join(path, "*")), fn(p)->
      if File.dir?(p) do
        do_find_page_paths(p)
      else
        p
      end
    end
  end
end
