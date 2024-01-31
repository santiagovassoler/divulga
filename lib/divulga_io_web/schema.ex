defmodule DivulgaIoWeb.Schema do
  use Absinthe.Schema
  alias DivulgaIo.{Repo, Accounts, Businesses}

  # Types
  import_types DivulgaIoWeb.Types.{User, Business, Address, Campaign}

  # Queries
  import_types DivulgaIoWeb.Schema.Queries.{User, Business, Campaign}

  # Mutations
  import_types DivulgaIoWeb.Schema.Mutations.{User, Business, Campaign, Address}

  # Subscriptions
  import_types DivulgaIoWeb.Schema.Subscription.Business

  query do
    import_fields :user_queries
    import_fields :business_queries
    import_fields :campaign_queries
  end

  mutation do
    import_fields :user_mutation
    import_fields :business_mutation
    import_fields :campaign_mutation
    import_fields :address_mutation
  end

  subscription do
    import_fields :business_subscription
  end

  def context(ctx) do
    source = Dataloader.Ecto.new(Repo)

    loader =
      Dataloader.new()
      |> Dataloader.add_source(Accounts, source)
      |> Dataloader.add_source(Businesses, source)

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
