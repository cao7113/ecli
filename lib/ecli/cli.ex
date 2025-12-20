defmodule Ecli.CLI do
  @moduledoc """
  CLI

  ## Links
  - [mix cli](https://github.com/elixir-lang/elixir/blob/main/lib/mix/lib/mix/cli.ex#L11)
  """

  alias Ecli.Util
  import IO, only: [puts: 1]

  @switches [
    help: :boolean,
    debug: :boolean,
    sleep: :integer,
    url: :string
  ]
  @aliases [
    h: :help,
    d: :debug,
    s: :sleep,
    u: :url
  ]

  @doc """
  escript cli entry
  """
  def main(args) do
    begin_at = System.monotonic_time()
    {opts, args} = OptionParser.parse!(args, strict: @switches, aliases: @aliases)

    action = List.first(args) || "help"
    debug? = opts[:debug]

    # todo whey is ""
    # version = Ecli.version()
    version = Application.spec(:ecli, :vsn) || "unknown"

    if debug? do
      puts("version: #{version} action: #{action} opts: #{opts |> inspect}")
    end

    case action do
      "info" ->
        if n = opts[:sleep] do
          Process.sleep(n * 100)
        end

        [
          vsn: version,
          build: System.build_info()
        ]
        |> dbg

      a when a in ["fetch", "cget", "url"] ->
        url = Enum.at(args, 2) || "https://httpbin.org/get"
        mix_curl(url, opts)

      _ ->
        puts(helps(action: action, vsn: version))
    end

    if debug? do
      duration = Util.get_duration(begin_at) / 1000
      puts("taken #{duration} ms")
    end
  end

  def helps(opts \\ []) do
    ~s"""
    ecli #{opts[:vsn]} usage:

    current action: #{opts[:action]}

    support actions:
      - help
      - info
    """
  end

  def mix_curl(url, opts \\ []) do
    if Code.loaded?(Mix.Utils) do
      Application.ensure_all_started(:mix)
      if opts[:verbose], do: puts("url: #{url}")

      with {:ok, resp} <- Mix.Utils.read_path(url) do
        puts(resp)
      else
        err ->
          puts("error: #{err |> inspect}")
      end
    else
      puts("not configured extra_applications: [:logger, :mix] in mix.exs")
    end
  end
end
