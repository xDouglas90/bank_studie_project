defmodule Transaction do
  @moduledoc """
  Module that stores the transactions occurred in the `transfer/3` and `withdraw/2` functions of the module `Account` in a txt file.
  """
  defstruct date: Date.utc_today, type: nil, value: 0, from: nil, to: nil
end
