defmodule DivulgaIoWeb.Schema.Mutations.Business do
  use Absinthe.Schema.Notation
  alias DivulgaIoWeb.Resolvers.Business

  object :business_mutation do
    field :create_business, :business do
      arg :name, non_null(:string)
      arg :description, non_null(:string)
      arg :user_id, non_null(:id)
      arg :address_id, :id

      resolve &Business.create_business/2
    end

    field :recommend_business, :business do
      arg :id, non_null(:id)

      resolve &Business.recommend_business/2
    end
  end
end
