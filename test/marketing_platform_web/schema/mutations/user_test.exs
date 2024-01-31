defmodule DivulgaIoWeb.Schema.Mutations.UserTest do
  alias DivulgaIo.Accounts
  alias DivulgaIoWeb.Schema
  use DivulgaIoWeb.DataCase, async: true

  @create_user_doc """
  mutation CreateUser($name: String!, $email: String!) {
    createUser(name: $name, email: $email) {
      id
      name
      email
    }
  }
  """

  describe "@createUser" do
    test "create an User" do
      name = "Test"
      email = "test@gmail.com"

      assert {:ok, %{data: data}} =
               Absinthe.run(@create_user_doc, Schema,
                 variables: %{
                   "email" => email,
                   "name" => name
                 }
               )

      user_res = data["createUser"]

      assert {:ok, %{name: ^name, email: ^email}} = Accounts.find_user(%{id: user_res["id"]})
    end
  end
end
