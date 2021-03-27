## defmodule BankStudieProject do
Small project to reinforce basic knowledge in [[Elixir]][elixir].

 - Basic sintax;
 - Private functions;
 - Patterning Matching;
 - Capture Operator;
 - Control structures;
 - Code refactoring..

For installing the language, follow the [official tutorial][install].

## API Reference

[TOCM]

[TOC]

### Modules
#### Account
Module that creates a new account based on the `struct` of `User` module.
##### Functions
###### delete/1
 Function that supports the functions `transfer/3` and` withdraw/2`,
  where it deletes past accounts as parameters of these functions,
  so that these functions can insert these accounts with their modified values,
  thus avoiding duplication of elements in the list.
  
 ###### register_user/1
   Function that creates a new account with the `struct` of the `user module` and the `balance`
  as parameters. It checks if there is already an account registered with the email informed
  through a private function, if not, it transforms the informed data
  into binaries through `:erlang.term_to_binary/1` and saves it in a txt file `File.write/2`.
  
  **Examples**
  ```elixir
      iex> Account.register_user(%User{name: "Douglas Oliveira", email: "xdouglas90@gmail.com"})
      %Account{balance: 1000, user: %User{email: "xdouglas90@gmail.com", name: "Douglas Oliveira"}}
```

###### transfer/3
  Function that when passing an `account that will transfer`,
  `account that you will receive` and the `amount` as parameters,
  performs the `transfer of amounts`,
  making sure the amount is not above the existing balance.
  With the aid of the function `delete/1`, it does not duplicate elements in the list.
  
 **Examples**
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
###### withdraw/2
  Function that when passing an `account` and a `value` as parameters,
  while this value being less than or equal to the one existing in the balance,
  makes the withdrawal.
  With the aid of the function `delete/1`, it does not duplicate elements in the list.
  
  **Examples**
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

#### Bank

#### Transaction
#### User


```elixir

```



## End
[elixir]: https://elixir-lang.org/ "Elixir"
[install]: https://elixir-lang.org/getting-started/introduction.html#installation "official tutorial"
## Installation

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

