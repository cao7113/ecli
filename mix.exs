defmodule Ecli.MixProject do
  use Mix.Project

  @version "0.1.0"
  @source_url "https://github.com/cao7113/ecli"

  def project do
    [
      app: :ecli,
      version: @version,
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript(),
      aliases: aliases(),
      description: "Escript cli",
      # for hex package
      source_url: @source_url,
      homepage_url: @source_url,
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      # :mix
      extra_applications: [:logger]
    ]
  end

  # Escript config: https://hexdocs.pm/mix/Mix.Tasks.Escript.Build.html
  def escript() do
    [
      main_module: Ecli.CLI,
      app: nil,
      name: :ecli,
      path: escript_path(Mix.env()),
      comment: "cli with escript"
    ]
  end

  def escript_path(:dev), do: "_build/ecli"
  def escript_path(_), do: nil

  def aliases do
    [
      up: "cmd MIX_ENV=prod mix escript.install --force"
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:git_ops, "~> 2.0", only: [:dev], runtime: false},
      # mix igniter.install git_ops
      {:igniter, "~> 0.7", only: [:dev, :test]}
      # {:req, "~> 0.5"}
    ]
  end

  # hex package metadata as
  # https://hex.pm/docs/publish#adding-metadata-to-code-classinlinemixexscode
  def package do
    [
      # name: "ecli",
      links: %{
        "GitHub" => @source_url,
        "Docs" => "https://hexdocs.pm/ecli"
      },
      files: ["lib", "mix.exs", "mix.lock", "README.md"],
      licenses: ["Apache-2.0"],
      maintainers: ["cao7113"]
    ]
  end
end
