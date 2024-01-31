defmodule DivulgaIoWeb.Resolvers.User do
  alias DivulgaIo.Accounts

  def find(%{id: id}, _) do
    id = String.to_integer(id)
    Accounts.find_user(%{id: id})
  end

  def create(params, _) do
    Accounts.create_user(params)
  end
end
