defmodule DivulgaIoWeb.Schema.Queries.Business do
  use Absinthe.Schema.Notation
  alias DivulgaIoWeb.Resolvers.Business

  object :business_queries do
    field :business, :business do
      arg :id, non_null(:id)

      resolve &Business.find_business/2
    end

    field :businesses, list_of(:business) do
      arg :recommendations_count, :integer
      arg :postcode, :string

      resolve &Business.all/2
    end

  end
end
