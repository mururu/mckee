defmodule Mckee.Mixfile do
  use Mix.Project

  def project do
    [ app: :mckee,
      version: "0.0.1",
      deps: deps ]
  end

  def application do
    []
  end

  defp deps do
    [
      { :dynamo, github: "josevalim/dynamo" },
      { :exmarkdown, github: "mururu/exmarkdown"},
      { :mustache, github: "mojombo/mustache.erl"},
      { :yamler, github: "voluntas/yamler"}
    ]
  end
end
