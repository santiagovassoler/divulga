defmodule DivulgaIoWeb.Schema.Mutations.Address do
  use Absinthe.Schema.Notation
  alias DivulgaIoWeb.Resolvers.Address

  object :address_mutation do
    field :create_address, :address do
      arg :business_id, non_null(:id)
      arg :first_line, :string
      arg :second_line, :string
      arg :city, :string
      arg :postcode, :string
      arg :country, :string

      resolve &Address.create_address/2
    end
  end
end
