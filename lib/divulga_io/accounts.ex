defmodule DivulgaIo.Accounts do
  import Ecto.Query, warn: false
  alias EctoShorts.Actions
  alias DivulgaIo.Accounts.User

  def create_user(attrs \\ %{}) do
    case Actions.create(User, attrs) do
      {:ok, user} -> {:ok, user}
      {:error, _} -> {:error, "Cannot create user"}
    end
  end

  def find_user(params) do
    case Actions.find(User, params) do
      {:ok, user} -> {:ok, user}
      {:error, _} -> {:error, "no user with that id"}
    end
  end
end
