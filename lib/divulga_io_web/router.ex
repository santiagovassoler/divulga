defmodule DivulgaIoWeb.Router do
  use DivulgaIoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/graphql", Absinthe.Plug, schema: DivulgaIoWeb.Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      interface: :playground,
      schema: DivulgaIoWeb.Schema,
      socket: DivulgaIoWeb.UserSocket
  end
end
