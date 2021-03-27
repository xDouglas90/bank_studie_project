defmodule Account do
  @moduledoc """
  Module that creates a new account based on the `struct` of `User module`.
  """
  defstruct user: User, balance: 1000
  @accounts "accounts.txt"

  @doc """
  Function that creates a new account with the `struct` of the `user module` and the `balance`
  as parameters. It checks if there is already an account registered with the email informed
  through a private function, if not, it transforms the informed data
  into binaries through `:erlang.term_to_binary/1` and saves it in a txt file `File.write/2`.

  ## Examples

      iex> Account.register_user(%User{name: "Douglas Oliveira", email: "xdouglas90@gmail.com"})
      %Account{balance: 1000, user: %User{email: "xdouglas90@gmail.com", name: "Douglas Oliveira"}}

  """
  def register_user(user) do
    accounts = get_accounts()

    case get_by_email(user.email) do
      nil ->
        binary =
          ([%__MODULE__{user: user}] ++ accounts)
          |> :erlang.term_to_binary()

        File.write(@accounts, binary)

      _ ->
        {:error, "Account already registered!"}
    end
  end

  defp get_accounts() do
    {:ok, binary} = File.read(@accounts)
    :erlang.binary_to_term(binary)
  end

  defp get_by_email(email), do: Enum.find(get_accounts(), &(&1.user.email == email))

  @doc """
  Function that when passing an `account that will transfer`,
  `account that you will receive` and the `amount` as parameters,
  performs the `transfer of amounts`,
  making sure the amount is not above the existing balance.
  With the aid of the function `delete/1`, it does not duplicate elements in the list.

  ## Examples

      iex> Account.transfer(
        %Account{
          balance: 1000,
          user: %User{
            email: "xdouglas90@gmail.com",
            name: "Douglas Oliveira"}
        },
        %Account{
          balance: 1000,
          user: %User{
            email: "anacfreire2109@gmail.com",
            name: "Ana Cristina"}
        }, 100)
      [
        %Account{
          balance: 900,
          user: %User{email: "xdouglas90@gmail.com", name: "Douglas Oliveira"}
        },
        %Account{
          balance: 1100,
          user: %User{email: "anacfreire2109@gmail.com", name: "Ana Cristina"}
        }
      ]
  """
  def transfer(from, to, value) do
    from = get_by_email(from)
    to = get_by_email(to)

    if balance_validate(from.balance, value) == true do
      {:error, "Insufficient funds!"}
    else
      accounts = Account.delete([from, to])
      from = %Account{from | balance: from.balance - value}
      to = %Account{to | balance: to.balance + value}
      accounts = accounts ++ [from, to]

      Transaction.save_transaction(
        "Transfer",
        from.user.email,
        value,
        Date.utc_today(),
        to.user.email
      )

      File.write(@accounts, :erlang.term_to_binary(accounts))
    end
  end

  @doc """
  Function that supports the functions `transfer/3` and` withdraw/2`,
  where it deletes past accounts as parameters of these functions,
  so that these functions can insert these accounts with their modified values,
  thus avoiding duplication of elements in the list.
  """
  def delete(accounts_delete) do
    Enum.reduce(accounts_delete, get_accounts(), fn a, acc -> List.delete(acc, a) end)
  end

  @doc """
  Function that when passing an `account` and a `value` as parameters,
  while this value being less than or equal to the one existing in the balance,
  makes the withdrawal.
  With the aid of the function `delete/1`, it does not duplicate elements in the list.


  ## Examples

      iex> account1 = Account.register_user(%User{name: "Douglas Oliveira", email: "xdouglas90@gmail.com"})
      %Account{
        balance: 1000,
        user: %User{email: "xdouglas90@gmail.com", name: "Douglas Oliveira"}
      }
      iex> Account.withdraw(account1, 10)
      {:ok,
        %Account{
          balance: 990,
          user: %User{email: "xdouglas90@gmail.com", name: "Douglas Oliveira"}
        }, "Withdrawal successful. Message forwarded by email!"}

  """
  def withdraw(account, value) do
    account = get_by_email(account)

    if balance_validate(account.balance, value) == true do
      {:error, "Insufficient funds!"}
    else
      accounts = Account.delete([account])
      account = %Account{account | balance: account.balance - value}
      accounts = accounts ++ [account]
      File.write(@accounts, :erlang.term_to_binary(accounts))
      {:ok, account, "Withdrawal successful. Message forwarded by email!"}
    end
  end

  defp balance_validate(balance, value), do: balance < value
end
