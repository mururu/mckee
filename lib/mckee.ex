defmodule Mckee do
  def pages_path do
    File.join static_root, "pages"
  end

  def layouts_path do
    File.join static_root, "layouts"
  end

  def static_root do
    File.expand_path("../../priv/static")
  end
end
