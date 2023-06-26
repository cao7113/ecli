defmodule Ecli do
  @moduledoc """
  Ecli - Cli with escript in elixir

  Ref mix impl.
  https://github.com/elixir-lang/elixir/blob/v1.15.0/lib/mix/lib/mix/cli.ex#L1C1-L1C1
  """

  @switches [
    verbose: :boolean,
    help: :boolean
  ]
  @aliases [v: :verbose]

  def main(args) do
    case check_for_shortcuts(args) do
      :help ->
        display_usage()

      # :version ->
      #   display_version()

      nil ->
        {_opts, args} = OptionParser.parse!(args, switches: @switches, aliases: @aliases)
        act = List.first(args)

        case act do
          "req" ->
            if length(args) < 2 do
              raise "require url in req action, like https://api.github.com/repos/elixir-lang/elixir"
            end

            url = Enum.at(args, 1)
            {:ok, _} = Application.ensure_all_started(:req)
            req = Eclient.get!(url)
            output("body: \n#{req.body |> inspect}")
        end
    end
  end

  defp display_usage do
    output("""
    Ecli is a tool with Elixir

    Usage: ecli [action]

    Examples:

        ecli             - show help
        ecli req API_URL - try api endpoint

    The --help and --version options can be given for usage and versioning information.
    """)
  end

  def output(info) do
    IO.puts(info)
  end

  # Check for --help or --version in the args
  defp check_for_shortcuts([]), do: :help
  defp check_for_shortcuts([arg]) when arg in ["--help", "-h"], do: :help
  defp check_for_shortcuts([arg]) when arg in ["--version", "-v"], do: :version
  defp check_for_shortcuts(_), do: nil
end
