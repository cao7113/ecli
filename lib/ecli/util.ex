defmodule Ecli.Util do
  def measure(fun, unit \\ :microsecond) when is_function(fun) do
    start = System.monotonic_time()
    result = fun.()
    duration = get_duration(start, unit)
    {{duration, unit}, result}
  end

  def get_duration(begin_at, unit \\ :microsecond, begin_unit \\ :native) do
    (System.monotonic_time() - begin_at)
    |> System.convert_time_unit(begin_unit, unit)
  end

  # def test(unit \\ :microsecond) do
  #   measure(fn -> :timer.sleep(100) end, unit)
  # end
end
