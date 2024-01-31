defmodule DivulgaIoWeb.Schema.Mutations.User do
  use Absinthe.Schema.Notation
  alias DivulgaIoWeb.Resolvers.User

  object :user_mutation do
    field :create_user, :user do
      arg :name, non_null(:string)
      arg :email, non_null(:string)

      resolve &User.create/2
    end
  end
end
