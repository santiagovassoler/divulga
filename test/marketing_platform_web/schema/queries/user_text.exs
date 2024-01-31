defmodule DivulgaIoWeb.Schemma.Queries.UserTest do
  use DivulgaIoWeb.DataCase, async: true

  alias DivulgaIo.Accounts
  alias DivulgaIoWeb.Schema

  @user_doc """
  query User($id: ID!) {
    user(id: $id) {
      id
      name
      email
    }
  }
  """

  describe "@user" do
    test "fetches user by id" do
      assert {:ok, user} = Accounts.create_user(%{email: "test@gmail.com", name: "Test"})
      assert {:ok, %{data: data}} = Absinthe.run(@user_doc, Schema, variables: %{"id" => user.id})
      assert data["user"]["id"] === to_string(user.id)
    end

    test "fetches user by id returns empty" do
      assert {:ok, %{data: data}} = Absinthe.run(@user_doc, Schema, variables: %{"id" => 100})
      assert data["user"] === nil
    end
  end
end
