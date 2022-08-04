defmodule DivulgaWeb.Resolvers.UserResolver do
    alias Divulga.Accounts

    def users(_,_,_) do
        {:ok, Accounts.list_users()}
    end
end