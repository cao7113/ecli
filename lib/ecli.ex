defmodule Ecli do
  @moduledoc """
  Documentation for `Ecli`.
  """

  @app :ecli

  def info do
    Application.spec(@app)
  end

  def version, do: info()[:vsn] |> to_string()
end
