defmodule Transaction do
  @moduledoc """
  Module that stores the transactions occurred in the `transfer/3` and `withdraw/2` functions of the module `Account` in a txt file.
  """
  defstruct date: Date.utc_today(), type: nil, value: 0, from: nil, to: nil
  @transactions "transactions.txt"

  @doc """
  Function that takes in its parameters the `type`, `sender account`, `amount`,
  `date` and `recipient account` (if any, in case of transfer) and through
  another private function stores this data in a txt file.
  """
  def save_transaction(type, from, value, date, to \\ nil) do
    transactions =
      get_transactions() ++
        [%__MODULE__{type: type, from: from, value: value, date: date, to: to}]

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

  @doc """
  Function that returns an error and a message in case of user call the function
  but do not put any year as a parameter.

  ## Examples

      iex> Account.transfer "xdouglas90@gmail.com", "juju.narnia@gmail.com", 15
      :ok
      iex> Transaction.load_by_year
      {:error, "Please enter a valid year."}

  """
  def load_by_year(), do: {:error, "Please enter a valid year."}

  @doc """
  Function that loads the data from the file `transactions.txt`
  by passing a `year` as parameter and shows on the console.
  Data received from a private function that stores the transaction history.


  ## Examples

      iex> Account.transfer "xdouglas90@gmail.com", "juju.narnia@gmail.com", 15
      :ok
      iex> Transaction.load_by_year 2021
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
  def load_by_year(year), do: Enum.filter(load_transactions(), &(&1.date.year == year))

  @doc """
  Function that loads the data from the file `transactions.txt`
  by passing a `year` and a `month` as parameters and shows on the console.
  Data received from a private function that stores the transaction history.


  ## Examples

      iex> Account.transfer "xdouglas90@gmail.com", "juju.narnia@gmail.com", 15
      :ok
      iex> Transaction.load_by_year 2021, 03
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
  def load_by_month(year, month),
    do: Enum.filter(load_transactions(), &(&1.date.year == year && &1.date.month == month))

  @doc """
  Function that loads the data by a day from the file `transactions.txt`
  by passing a date (`~D[YYYY-MM-DD]`) as parameter and shows on the console.
  Data received from a private function that stores the transaction history.


  ## Examples

      iex> Account.transfer "xdouglas90@gmail.com", "juju.narnia@gmail.com", 15
      :ok
      iex> Transaction.load_by_year ~D[2021-03-26]
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
  def load_by_day(date), do: Enum.filter(load_transactions(), &(&1.date == date))

  @doc """
  function that calculates the total value of all transactions made, using the data loaded by the function `load_transactions/0`.
  Returns the transactions made and the total value in a tuple.
  The calculation is done through a private function.


  ## Examples

      iex> Account.transfer "xdouglas90@gmail.com", "juju.narnia@gmail.com", 15
      :ok
      iex> Account.transfer "xdouglas90@gmail.com", "juju.narnia@gmail.com", 15
      :ok
      iex> Transaction.total_transactions
      {[
        %Transaction{
          date: ~D[2021-03-26],
          from: "xdouglas90@gmail.com",
          to: "juju.narnia@gmail.com",
          type: "Transfer",
          value: 15
        },
        %Transaction{
          date: ~D[2021-03-26],
          from: "xdouglas90@gmail.com",
          to: "juju.narnia@gmail.com",
          type: "Transfer",
          value: 15
        }
      ], 30}

  """
  def total_transactions(), do: load_transactions() |> calculate

  @doc """
  function that calculates the total value of transactions made in the `month` informed
  as a parameter, using the data loaded by the function `load_by_month/2`.
  Returns the transactions made and the total value in a tuple.
  The calculation is done through a private function.


  ## Examples

      iex> Account.transfer "xdouglas90@gmail.com", "juju.narnia@gmail.com", 15
      :ok
      iex> Account.transfer "xdouglas90@gmail.com", "juju.narnia@gmail.com", 15
      :ok
      iex> Transaction.total_by_month 2021, 03
      {[
        %Transaction{
          date: ~D[2021-03-26],
          from: "xdouglas90@gmail.com",
          to: "juju.narnia@gmail.com",
          type: "Transfer",
          value: 15
        },
        %Transaction{
          date: ~D[2021-03-26],
          from: "xdouglas90@gmail.com",
          to: "juju.narnia@gmail.com",
          type: "Transfer",
          value: 15
        }
      ], 30}

  """
  def total_by_month(year, month), do: load_by_month(year, month) |> calculate

  @doc """
  function that calculates the total value of transactions made in the `year` informed
  as a parameter, using the data loaded by the function `load_by_year/1`.
  Returns the transactions made and the total value in a tuple.
  The calculation is done through a private function.


  ## Examples

      iex> Account.transfer "xdouglas90@gmail.com", "juju.narnia@gmail.com", 15
      :ok
      iex> Account.transfer "xdouglas90@gmail.com", "juju.narnia@gmail.com", 15
      :ok
      iex> Transaction.total_by_year 2021
      {[
        %Transaction{
          date: ~D[2021-03-26],
          from: "xdouglas90@gmail.com",
          to: "juju.narnia@gmail.com",
          type: "Transfer",
          value: 15
        },
        %Transaction{
          date: ~D[2021-03-26],
          from: "xdouglas90@gmail.com",
          to: "juju.narnia@gmail.com",
          type: "Transfer",
          value: 15
        }
      ], 30}

  """
  def total_by_year(year), do: load_by_year(year) |> calculate

  @doc """
  function that calculates the total value of transactions made in the day with the date (`~D[YYYY-MM-DD]`) informed
  as a parameter, using the data loaded by the function `load_by_day/1`.
  Returns the transactions made and the total value in a tuple.
  The calculation is done through a private function.


  ## Examples

      iex> Account.transfer "xdouglas90@gmail.com", "juju.narnia@gmail.com", 15
      :ok
      iex> Account.transfer "xdouglas90@gmail.com", "juju.narnia@gmail.com", 15
      :ok
      iex> Transaction.total_by_month ~D[2021-03-26]
      {[
        %Transaction{
          date: ~D[2021-03-26],
          from: "xdouglas90@gmail.com",
          to: "juju.narnia@gmail.com",
          type: "Transfer",
          value: 15
        },
        %Transaction{
          date: ~D[2021-03-26],
          from: "xdouglas90@gmail.com",
          to: "juju.narnia@gmail.com",
          type: "Transfer",
          value: 15
        }
      ], 30}

  """
  def total_by_day(date), do: load_by_day(date) |> calculate

  defp calculate(transactions) do
    {transactions, Enum.reduce(transactions, 0, fn x, acc -> acc + x.value end)}
  end

  defp get_transactions do
    {:ok, binary} = File.read(@transactions)

    binary
    |> :erlang.binary_to_term()
  end
end
