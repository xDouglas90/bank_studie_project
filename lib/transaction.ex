defmodule Transaction do
  @moduledoc """
  Module that stores the transactions occurred in the `transfer/3` and `withdraw/2` functions of the module `Account` in a txt file.
  """
  defstruct date: Date.utc_today, type: nil, value: 0, from: nil, to: nil
  @transactions "transactions.txt"

  def save_transaction(type, from, value, date, to \\ nil) do
    transactions =
      get_transactions() ++ [%__MODULE__{type: type, from: from, value: value, date: date, to: to}]
    File.write(@transactions, :erlang.term_to_binary(transactions))
  end

  def load_transactions, do: get_transactions()

  defp get_transactions do
    {:ok, binary} = File.read(@transactions)
    binary
    |> :erlang.binary_to_term()
  end
end
