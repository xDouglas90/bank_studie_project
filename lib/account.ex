defmodule Account do
  @moduledoc """
  Module that creates a new account based on the `struct` of `User module`.
  """
  defstruct user: User, balance: nil

  @doc """
  Function that creates a new account receiving data from the `User module` and passing a `balance` as a parameter,
  according to the `defstruct user: User, balance: nil` created.

  ## Examples

      iex> Account.register_user(%User{name: "Douglas Oliveira", email: "xdouglas90@gmail.com"})
      %Account{balance: 1000, user: %User{email: "xdouglas90@gmail.com", name: "Douglas Oliveira"}}

  """
  def register_user(user) do
    %__MODULE__{user: user, balance: 1000}
  end

end
