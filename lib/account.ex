defmodule Account do
  @moduledoc """
  Module that creates a new account based on the `struct` of `User module`.
  """
  defstruct user: User, balance: 1000

  @doc """
  Function that creates a new account receiving data from the `User module` and passing a `balance` as a parameter,
  according to the `defstruct user: User, balance: nil` created.

  ## Examples

      iex> Account.register_user(%User{name: "Douglas Oliveira", email: "xdouglas90@gmail.com"})
      %Account{balance: 1000, user: %User{email: "xdouglas90@gmail.com", name: "Douglas Oliveira"}}

  """
  def register_user(user) do
    %__MODULE__{user: user}
  end

  @doc """
  Function that when passing a list of accounts as parameters,
  account that will transfer, account that you will receive and the amount,
  performs the transfer of amounts,
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

    cond do
      balance_validate(from.balance, value) -> {:error, "Insufficient funds!"}
      true ->
        to = Enum.find(accounts, fn account -> account.user.email == to.user.email end)
        from = %Account{from | balance: from.balance - value}
        to = %Account{to | balance: to.balance + value}
      [from, to]
    end
  end

  def withdraw(account, value) do
    cond do
      balance_validate(account.balance, value) -> {:error, "Insufficient funds!"}
      true ->
        account = %Account{account | balance: account.balance - value}
        {:ok, account, "Withdrawal successful. Message forwarded by email!"}
    end
  end

  defp balance_validate(balance, value), do: balance < value
end
