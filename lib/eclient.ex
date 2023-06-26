defmodule Eclient do
  @moduledoc """
  Escript-friendly HTTP client backed by great Req & Finch & Mint!
  """

  def get!(url, opts \\ []) do
    Req.get!(url, req_opts(opts))
  end

  def req_opts(opts \\ []) do
    [
      connect_options: [
        transport_opts: [
          # Issue: (ArgumentError) unknown application: :castore in escript
          # default verify strategy
          # verify: :verify_peer
          # or use
          # verify: :verify_none
          cacerts: :public_key.cacerts_get()
        ]
      ]
    ]
    |> Keyword.merge(opts)
  end
end
