defmodule DivulgaWeb.Schema do
  use Absinthe.Schema
  alias Divulga.{Repo, Accounts}
  alias DivulgaWeb.Resolvers
  alias DivulgaWeb.Schema.Middleware

  import_types(DivulgaWeb.Schema.Types)

  def middleware(middleware, _field, %{identifier: :mutation}) do
    middleware ++ [Middleware.ChangesetErrors]
  end

  def middleware(middleware, _field, _object), do: middleware

  def context(ctx) do
    source = Dataloader.Ecto.new(Repo)
    loader = Dataloader.new()
    |> Dataloader.add_source(Accounts, source)
    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  query do
    @desc "Get a list of all users"
    field :users, list_of(:user_type) do
      middleware(Middleware.Authorize, :any)
      resolve(&Resolvers.UserResolver.users/3)
    end
  end

  mutation do
    @desc "Register a new user"
    field :register_user, type: :user_type do
      arg(:input, non_null(:user_input_type))
      resolve(&Resolvers.UserResolver.register_user/3)
    end

    @desc "Login a user and return a JWT token"
    field :login_user, type: :session_type do
      arg(:input, non_null(:session_input_type))
      resolve(&Resolvers.SessionResolver.login_user/3)
    end

    @desc "Create a Business"
    field :create_business, type: :business_type do
      arg(:input, non_null(:business_input_type))
      middleware(Middleware.Authorize, :any)
      resolve(&Resolvers.BusinessResolver.create_business/3)
    end
  end
end
