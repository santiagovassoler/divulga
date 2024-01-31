defmodule DivulgaIoWeb.Resolvers.Address do
  alias DivulgaIo.Businesses

  def create_address(params, _) do
    Businesses.create_address(params)
  end
end
