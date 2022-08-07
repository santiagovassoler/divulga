defmodule DivulgaWeb.Resolvers.BusinessResolver do
  alias Divulga.Advert

  def create_business(_, %{input: input}, %{context: %{current_user: current_user}}) do
    Map.merge(input, %{user_id: current_user.id})
    |> Advert.create_business()
  end
end
