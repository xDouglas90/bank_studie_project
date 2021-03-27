# defmodule BankStudieProject do
Small project to reinforce basic knowledge in [Elixir][Elixir].

 - Basic sintax;
 - Private functions;
 - Patterning Matching;
 - Capture Operator;
 - Control structures;
 - Code refactoring..

For installing the language, follow the [official tutorial][install].

# API Reference

------------


## Modules
### Account
Module that creates a new account based on the `struct` of `User` module.
#### Functions

------------


##### delete/1
 Function that supports the functions `transfer/3` and` withdraw/2`,
  where it deletes past accounts as parameters of these functions,
  so that these functions can insert these accounts with their modified values,
  thus avoiding duplication of elements in the list.
  
  

------------


 ##### register_user/1
   Function that creates a new account with the `struct` of the `user module` and the `balance`
  as parameters. It checks if there is already an account registered with the email informed
  through a private function, if not, it transforms the informed data
  into binaries through `:erlang.term_to_binary/1` and saves it in a txt file `File.write/2`.
  
  *Examples*
  ```elixir
      iex> Account.register_user(%User{name: "Douglas Oliveira", email: "xdouglas90@gmail.com"})
      %Account{balance: 1000, user: %User{email: "xdouglas90@gmail.com", name: "Douglas Oliveira"}}
```

------------


##### transfer/3
  Function that when passing an `account that will transfer`,
  `account that you will receive` and the `amount` as parameters,
  performs the `transfer of amounts`,
  making sure the amount is not above the existing balance.
  With the aid of the function `delete/1`, it does not duplicate elements in the list.
  
 *Examples*
 ```elixir
      iex> Account.transfer(%Account{balance: 1000, user: %User{ email: "xdouglas90@gmail.com", name: "Douglas Oliveira"}}, %Account{balance: 1000, user: %User{email: "anacfreire2109@gmail.com", name: "Ana Cristina"} }, 100)
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
```

------------


##### withdraw/2
  Function that when passing an `account` and a `value` as parameters,
  while this value being less than or equal to the one existing in the balance,
  makes the withdrawal.
  With the aid of the function `delete/1`, it does not duplicate elements in the list.
  
  *Examples*
```elixir
      iex> account1 = Account.register_user(%User{name: "Douglas Oliveira", email: "xdouglas90@gmail.com"})
      %Account{
        balance: 1000,
        user: %User{email: "xdouglas90@gmail.com", name: "Douglas Oliveira"}
      }
	 iex>  Account.withdraw(account1, 10)
      {:ok,
        %Account{
          balance: 990,
          user: %User{email: "xdouglas90@gmail.com", name: "Douglas Oliveira"}
        }, "Withdrawal successful. Message forwarded by email!"}
```  

------------


### Bank
Mini Project with the objective of learning and reinforcing Elixir's knowledge.
#### Functions

------------


##### hello/0
Hello world.
  *Examples*
```elixir
	iex> Bank.hello()
    :world
```  

------------


### Transaction
Module that stores and do operations with the transactions occurred in the `transfer/3` and `withdraw/2` functions of the module `Account` in a txt file.
#### Functions

------------


##### save_transaction/5
Function that takes in its parameters the `type`, `sender account`, `amount`, `date` and `recipient account` (if any, in case of transfer) and through another private function stores this data in a txt file.

------------


##### load_transactions/0
Function that loads the data from the file `transactions.txt` and shows on the console. Data received from a private function that stores the transaction history.

*Examples*
```elixir
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

```

------------


##### load_by_year/0
  Function that returns an error and a message in case of user call the function but do not put any year as a parameter.

*Examples*
```elixir
      iex> Account.transfer "xdouglas90@gmail.com", "juju.narnia@gmail.com", 15
      :ok
      iex> Transaction.load_by_year
      {:error, "Please enter a valid year."}

```

------------


##### load_by_year/1
  Function that loads the data from the file `transactions.txt` by passing a `year` as parameter and shows on the console. Data received from a private function that stores the transaction history.

*Examples*
```elixir
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

```

------------


##### load_by_month/2
   Function that loads the data from the file `transactions.txt` by passing a `year` and a `month` as parameters and shows on the console. Data received from a private function that stores the transaction history.

*Examples*
```elixir
      iex> Account.transfer "xdouglas90@gmail.com", "juju.narnia@gmail.com", 15
      :ok
      iex> Transaction.load_by_month 2021, 03
      [
        %Transaction{
          date: ~D[2021-03-26],
          from: "xdouglas90@gmail.com",
          to: "juju.narnia@gmail.com",
          type: "Transfer",
          value: 15
        }
      ]

```

------------


##### load_by_day/1
  Function that loads the data by a day from the file `transactions.txt` by passing a date (`~D[YYYY-MM-DD]`) as parameter and shows on the console. Data received from a private function that stores the transaction history.

*Examples*
```elixir
      iex> Account.transfer "xdouglas90@gmail.com", "juju.narnia@gmail.com", 15
      :ok
      iex> Transaction.load_by_day ~D[2021-03-26]
      [
        %Transaction{
          date: ~D[2021-03-26],
          from: "xdouglas90@gmail.com",
          to: "juju.narnia@gmail.com",
          type: "Transfer",
          value: 15
        }
      ]

```

------------


##### total_transactions/0
  Function that calculates the total value of all transactions made, using the data loaded by the function `load_transactions/0`. Returns the transactions made and the total value in a tuple.
  The calculation is done through a private function.

*Examples*
```elixir
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

```

------------


##### total_by_month/2
  Function that calculates the total value of transactions made in the `month` informed as a parameter, using the data loaded by the function `load_by_month/2`. Returns the transactions made and the total value in a tuple.
  The calculation is done through a private function.

*Examples*
```elixir
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

```

------------



##### total_by_year/1
  Function that calculates the total value of transactions made in the `year` informed as a parameter, using the data loaded by the function `load_by_year/1`. Returns the transactions made and the total value in a tuple.
  The calculation is done through a private function.

*Examples*
```elixir
      iex> Account.transfer "xdouglas90@gmail.com", "juju.narnia@gmail.com", 100
      :ok
      iex> Account.transfer "xdouglas90@gmail.com", "juju.narnia@gmail.com", 200
      :ok
      iex> Transaction.total_by_year 2021
      {[
        %Transaction{
          date: ~D[2021-03-26],
          from: "xdouglas90@gmail.com",
          to: "juju.narnia@gmail.com",
          type: "Transfer",
          value: 100
        },
        %Transaction{
          date: ~D[2021-03-26],
          from: "xdouglas90@gmail.com",
          to: "juju.narnia@gmail.com",
          type: "Transfer",
          value: 200
        }
      ], 300}

```

------------


##### total_by_day/1
  Function that calculates the total value of transactions made in the day with the date (`~D[YYYY-MM-DD]`) informed as a parameter, using the data loaded by the function `load_by_day/1`. Returns the transactions made and the total value in a tuple.
  The calculation is done through a private function.

*Examples*
```elixir
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

```

------------



### User
 Module that creates a new user based on the struct `defstruct name: nil, email: nil` created.

#### Functions

------------


##### new_user/2
  Function that creates a new user by passing the `name` and `email` parameters,
  according to the module struct.
  
  *Examples*
```elixir
      iex> User.new_user("Douglas Oliveira", "xdouglas90@gmail.com")
      %User{email: "xdouglas90@gmail.com", name: "Douglas Oliveira"}
```

------------

## End

------------


[elixir]: https://elixir-lang.org/ "Elixir"
[install]: https://elixir-lang.org/getting-started/introduction.html#installation "official tutorial"
## API Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `bank` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:bank, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/bank](https://hexdocs.pm/bank).


[Elixir]: https://elixir-lang.org/ "Elixir"
