defmodule DivulgaWeb.Resolvers.BusinessResolver do
  alias Divulga.Advert

  def create_business(_, %{input: input}, %{context: %{user: user}}) do
    Map.merge(input, %{user_id: user.id})
    |> Advert.create_business()
  end
end
