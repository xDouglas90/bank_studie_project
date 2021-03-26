defmodule Transaction do
  @moduledoc """
  Module that stores the transactions occurred in the `transfer/3` and `withdraw/2` functions of the module `Account` in a txt file.
  """
  defstruct date: Date.utc_today, type: nil, value: 0, from: nil, to: nil
  @transactions "transactions.txt"

  @doc """
  Function that takes in its parameters the `type`, `sender account`, `amount`,
  `date` and `recipient account` (if any, in case of transfer) and through
  another private function stores this data in a txt file.
  """
  def save_transaction(type, from, value, date, to \\ nil) do
    transactions =
      get_transactions() ++ [%__MODULE__{type: type, from: from, value: value, date: date, to: to}]
    File.write(@transactions, :erlang.term_to_binary(transactions))
  end

  @doc """
  Function that loads the data from the file `transactions.txt` and
  shows on the console. Data received from a private function that stores
  the transaction history.


  ## Examples

      iex> Account.transfer "xdouglas90@gmail.com", "juju.narnia@gmail.com", 15
      :ok
      iex> Transaction.load_transactions
      [
        %Transaction{
          date: ~D[2021-03-26],
          from: "xdouglas90@gmail.com",
          to: "juju.narnia@gmail.com",
          type: "Transfer",
          value: 15
        }
      ]

  """
  def load_transactions, do: get_transactions()

  def load_by_year(), do: {:error, "Please enter a valid year."}

  def load_by_year(year), do: Enum.filter(load_transactions(), &(&1.date.year == year))

  def load_by_month(year, month), do: Enum.filter(load_transactions(), &(&1.date.year == year && &1.date.month == month))

  defp get_transactions do
    {:ok, binary} = File.read(@transactions)
    binary
    |> :erlang.binary_to_term()
  end
end
