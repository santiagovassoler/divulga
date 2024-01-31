defmodule DivulgaIoWeb.Schema.Mutations.Campaign do
  use Absinthe.Schema.Notation
  alias DivulgaIoWeb.Resolvers.Campaign

  object :campaign_mutation do
    field :create_campaign, :campaign do
      arg :slug, non_null(:string)
      arg :description, non_null(:string)
      arg :business_id, non_null(:id)

      resolve &Campaign.create_campaign/2
    end

    field :remove_campaign, :boolean do
      arg :id, non_null(:id)

      resolve &Campaign.remove_campaign/2
    end
  end
end
