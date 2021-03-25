defmodule Account do
  @moduledoc """
  Module that creates a new account based on the `struct` of `User module`.
  """
  defstruct user: User, balance: 1000
  @accounts "accounts.txt"

  @doc """
  Function that creates a new account receiving data from the `User module` and passing a `balance` as a parameter,
  according to the `defstruct user: User, balance: nil` created.

  ## Examples

      iex> Account.register_user(%User{name: "Douglas Oliveira", email: "xdouglas90@gmail.com"})
      %Account{balance: 1000, user: %User{email: "xdouglas90@gmail.com", name: "Douglas Oliveira"}}

  """
  def register_user(user) do
    accounts = get_accounts()
    binary = [%__MODULE__{user: user}] ++ accounts
    |> :erlang.term_to_binary()
    File.write(@accounts, binary)
  end

  def get_accounts do
    {:ok, binary} = File.read(@accounts)
    :erlang.binary_to_term(binary)
  end

  def get_by_email(email), do: Enum.find(get_accounts(), &(&1.user.email == email))

  @doc """
  Function that when passing a `list of accounts`,
  `account that will transfer`, `account that you will receive` and the `amount` as parameters,
  performs the `transfer of amounts`,
  making sure the amount is not above the existing balance.

  ## Examples
      iex> account1 = Account.register_user(%User{name: "Douglas Oliveira", email: "xdouglas90@gmail.com"})
      %Account{
        balance: 1000,
        user: %User{email: "xdouglas90@gmail.com", name: "Douglas Oliveira"}
      }
      iex> account2 = Account.register_user(%User{name: "Ana Cristina", email: "anacfreire2109@gmail.com"})
      %Account{
        balance: 1000,
        user: %User{email: "anacfreire2109@gmail.com", name: "Ana Cristina"}
      }
      iex> accounts = [account1, account2]
      [
        %Account{
          balance: 1000,
          user: %User{email: "xdouglas90@gmail.com", name: "Douglas Oliveira"}
        },
        %Account{
          balance: 1000,
          user: %User{email: "anacfreire2109@gmail.com", name: "Ana Cristina"}
        }
      ]
      iex> Account.transfer(accounts, account1, account2, 100)
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
  def transfer(accounts, from, to, value) do
    from = Enum.find(accounts, fn account -> account.user.email == from.user.email end)

    if balance_validate(from.balance, value) == true
    do
      {:error, "Insufficient funds!"}
    else
      to = Enum.find(accounts, fn account -> account.user.email == to.user.email end)
      from = %Account{from | balance: from.balance - value}
      to = %Account{to | balance: to.balance + value}
      [from, to]
    end
  end

  @doc """
  Function that when passing an `account` and a `value` as parameters,
  while this value being less than or equal to the one existing in the balance,
  `makes the withdrawal`.

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
    if balance_validate(account.balance, value) == true
    do
      {:error, "Insufficient funds!"}
    else
        account = %Account{account | balance: account.balance - value}
        {:ok, account, "Withdrawal successful. Message forwarded by email!"}
    end
  end

  defp balance_validate(balance, value), do: balance < value
end
