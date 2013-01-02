defmodule Mix.Tasks.Mckee do
  use Mix.Task
  import Mix.Generator

  def run(_) do
    create_directory "priv/static/layouts"
    create_directory "priv/static/pages"

    Mix.shell.info """

    To enable Mckee add to the ApplicationRouter:
      forward "/", to: Mckee.Router
    """
  end
end
