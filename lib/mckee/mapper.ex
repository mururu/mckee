defmodule Mckee.Mapper do
  defmacro __using__(_) do
    paths = find_page_paths
    gets = Enum.map paths, fn(path)->
      { route, html } = Mckee.Markdown.compile(path)
      Code.string_to_ast! """
        Module.put_attribute __MODULE__, :routes, "#{route}"
        get "#{route}" do
          conn.resp_body "#{html}"
        end
      """
    end
    [ Code.string_to_ast! "Module.register_attribute __MODULE__, :routes, accumulate: true" ] ++
    gets ++
    [ Code.string_to_ast! "def routes, do: @routes" ]
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
