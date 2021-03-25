defmodule User do
  @moduledoc """
  Module that creates a new user based on the `struct` created.
  """
  defstruct name: nil, email: nil

  @doc """
  Function that creates a new user by passing the `name` and `email` parameters,
  according to the `struct`.

  ## Examples

      iex> User.new_user("Douglas Oliveira", "xdouglas90@gmail.com")
      %User{email: "xdouglas90@gmail.com", name: "Douglas Oliveira"}

  """
  def new_user(name, email) do
    %__MODULE__{name: name, email: email}
  end

end
