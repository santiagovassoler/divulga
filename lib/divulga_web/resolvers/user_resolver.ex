defmodule DivulgaWeb.Resolvers.UserResolver do
  alias Divulga.Accounts

  def users(_, _, _) do
    {:ok, Accounts.list_users()}
  end

  def register_user(_, %{input: input}, _) do
    with {:ok, user} <- Accounts.create_user(input) do
      {:ok, user}
    end
  end
end
