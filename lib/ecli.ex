defmodule Ecli do
  @moduledoc """
  Prints args, possibly multiple times.

  Usage:
    $ ecli {options} arg1 arg2 ...

  Options:
    --verbose     Add more info.
    --count=n     Print n times.
  """

  def main([]), do: IO.puts(@moduledoc)
  def main([opt]) when opt in ["-h", "--help"], do: IO.puts(@moduledoc)

  def main(args) do
    {opts, pargs, errors} = args |> parse_args

    case errors do
      [] ->
        process_args(opts, pargs)
        show_jason(pargs)

      _ ->
        errors |> IO.inspect(label: "Bad options")
        IO.puts(@moduledoc)
    end
  end

  defp parse_args(args) do
    args
    |> OptionParser.parse(
      strict: [
        verbose: :boolean,
        count: :integer
      ],
      aliases: [c: :count]
    )

    # {opts, cmd_and_args, errors}
  end

  defp process_args(opts, args) do
    count = Keyword.get(opts, :count, 1)

    printfn =
      if Keyword.has_key?(opts, :verbose) do
        fn arg ->
          IO.write("Message: ")
          IO.puts(arg)
        end
      else
        fn arg ->
          IO.puts(arg)
        end
      end

    Stream.iterate(0, &(&1 + 1))
    |> Stream.take(count)
    |> Enum.each(fn _counter ->
      Enum.with_index(args, fn arg, idx ->
        printfn.("#{idx}. #{arg}")
      end)
    end)
  end

  defp show_jason(args) do
    args
    |> Jason.encode!()
    |> IO.inspect(label: "JSON content")
  end
end
