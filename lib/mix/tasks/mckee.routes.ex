defmodule Mix.Tasks.Mckee.Routes do
  use Mix.Task

  def run(_) do
    Mix.shell.info "Routes you defined"
    Mix.shell.info "---"

    Enum.each Mckee.Router.routes, fn(route)->
      Mix.shell.info "#{route}"
    end
  end
end
