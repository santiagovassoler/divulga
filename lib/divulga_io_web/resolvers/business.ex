defmodule DivulgaIoWeb.Resolvers.Business do
  alias DivulgaIo.Businesses

  def all(params, _) do
    Businesses.list_business(params)
  end

  def find_business(%{id: id}, _) do
    id = String.to_integer(id)
    Businesses.find_business(%{id: id})
  end

  def create_business(params, _) do
    Businesses.create_business(params)
  end

  def recommend_business(%{id: id}, _) do
    id = String.to_integer(id)
    Businesses.recommend_business(id)
  end
end
