defmodule Ecli.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecli,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      # https://hexdocs.pm/mix/Mix.Tasks.Escript.Build.html
      escript: [
        main_module: Ecli,
        app: nil,
        name: :ecli,
        # path: "bin/ecli",
        comment: "cli with escript"
      ],
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :inets]
    ]
  end

  def aliases do
    [
      up: "cmd MIX_ENV=prod mix escript.install --force"
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      # {:jason, "~> 1.4"},
      {:req, "~> 0.3"}
    ]
  end
end
