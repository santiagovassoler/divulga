defmodule DivulgaIoWeb.Schema.Mutations.BusinessTest do
  alias DivulgaIo.Accounts
  use DivulgaIoWeb.DataCase, async: true

  alias DivulgaIo.Businesses
  alias DivulgaIoWeb.Schema

  setup do
    {:ok, user} = Accounts.create_user(%{email: "test@gmail.com", name: "Test"})
    {:ok, user: user}
  end

  @create_business_doc """
    mutation CreateBusiness($addressId: ID, $userId: ID!, $description: String!, $name: String!){
      createBusiness(addressId: $addressId, userId: $userId, description: $description, name: $name){
        id
        name
      }
    }
  """

  describe "@createBusiness" do
    test "create business", %{user: user} do

      assert {:ok, %{data: data}} =
               Absinthe.run(@create_business_doc, Schema,
                 variables: %{
                   "userId" => user.id,
                   "name" => "new-business",
                   "description" => "we sell everything!",
                 }
               )

      assert data["createBusiness"]["name"] === "new-business"
    end
  end

  @recommend_business_doc """
    mutation RecommendBusiness($id: ID!){
      recommendBusiness(id: $id){
        id
        name
        recommendationsCount
      }
    }
  """

  describe "@recommendBusiness" do
    test "recommend business", %{user: user} do

      assert {:ok, business} =
        Businesses.create_business(%{
          description: "description test",
          name: "test",
          user_id: user.id,
        })

      assert business.recommendations_count === 0

      assert {:ok, %{data: data}} =
               Absinthe.run(@recommend_business_doc, Schema,
                 variables: %{
                   "id" => business.id,
                 }
               )

      assert data["recommendBusiness"]["recommendationsCount"] === 1
    end

    test "recommend business returns error with business not found" do

      assert {:ok, %{data: data, errors: errors}} =
               Absinthe.run(@recommend_business_doc, Schema,
                 variables: %{
                   "id" => "999",
                 }
               )

      assert data["recommendBusiness"] === nil
      assert List.first(errors)[:message] === "No business with that id"
    end
  end
end
