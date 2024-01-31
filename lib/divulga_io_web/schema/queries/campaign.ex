defmodule DivulgaIoWeb.Schema.Queries.Campaign do
  use Absinthe.Schema.Notation
  alias DivulgaIoWeb.Resolvers.Campaign

  object :campaign_queries do
    field :campaign, :campaign do
      arg :id, non_null(:id)

      resolve &Campaign.find_campaign/2
    end
  end
end
