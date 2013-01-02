defmodule Mix.Tasks.Mckee.Recompile do
  use Mix.Task

  def run(_) do
    File.rm_rf "deps/mckee/ebin"
    Mix.Task.run "deps.compile", ["mckee"]
  end
end
