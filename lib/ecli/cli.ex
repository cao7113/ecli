defmodule Ecli.CLI do
  @moduledoc """
  CLI

  ## Links
  - [mix cli](https://github.com/elixir-lang/elixir/blob/main/lib/mix/lib/mix/cli.ex#L11)
  """

  require Logger

  @switches [
    help: :boolean,
    verbose: :boolean,
    url: :string
  ]
  @aliases [
    h: :help,
    v: :verbose,
    u: :url
  ]

  @doc """
  escript cli entry
  """
  def main(args) do
    {opts, args} = OptionParser.parse_head!(args, strict: @switches, aliases: @aliases)

    action = List.first(args) || "help"
    verbose = opts[:verbose]

    # todo whey is ""
    # version = Ecli.version()
    version = Application.spec(:ecli, :vsn) || "unknown"

    if verbose do
      Logger.debug("version: #{version} action: #{action}")
    end

    case action do
      "info" ->
        [
          vsn: version,
          build: System.build_info()
        ]
        |> dbg

      # "hi" ->
      #   # whether other module auto included in final escript, yes!
      #   Ecli.Hi.ping() |> dbg

      a when a in ["fetch", "cget", "url"] ->
        url = Enum.at(args, 2) || "https://httpbin.org/get"
        mix_curl(url, opts)

      _ ->
        IO.puts(helps(vsn: version))
    end
  end

  def helps(opts \\ []) do
    ~s"""
    ecli #{opts[:vsn]} usage:

    support actions:
      - help
      - info
    """
  end

  def mix_curl(url, opts \\ []) do
    if Code.loaded?(Mix.Utils) do
      Application.ensure_all_started(:mix)
      if opts[:verbose], do: IO.puts("url: #{url}")

      with {:ok, resp} <- Mix.Utils.read_path(url) do
        IO.puts(resp)
      else
        err ->
          Logger.error("error: #{err |> inspect}")
      end
    else
      Logger.error("not configured extra_applications: [:logger, :mix] in mix.exs")
    end
  end
end
