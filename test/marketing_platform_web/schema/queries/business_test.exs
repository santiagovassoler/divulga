defmodule DivulgaIoWeb.Schema.Queries.BusinessTest do
  alias DivulgaIo.Accounts
  use DivulgaIoWeb.DataCase, async: true

  alias DivulgaIo.Businesses
  alias DivulgaIoWeb.Schema

  setup do
    {:ok, user} = Accounts.create_user(%{email: "test@gmail.com", name: "Test"})
    {:ok, business} = Businesses.create_business(%{description: "description test", name: "test", user_id: user.id})

    {:ok, business: business}
  end

  @business_doc """
  query Business($id: ID!) {
    business(id: $id) {
      id
      name
    }
  }
  """

  describe "@business" do
    test "fetches business by id", %{business: business} do
      assert {:ok, %{data: data}} = Absinthe.run(@business_doc, Schema, variables: %{"id" => business.id})
      assert data["business"]["id"] === to_string(business.id)
    end

    test "fetches business by id returns empty" do
      assert {:ok, %{data: data}} = Absinthe.run(@business_doc, Schema, variables: %{"id" => 100})
      assert data["business"] === nil
    end
  end

  @businesses_doc """
  query AllBusiness($postcode: String, $recommendationsCount: Int) {
    businesses(postcode: $postcode, recommendationsCount: $recommendationsCount) {
      id
      addresses {
        id
        postcode
      }
    }
  }
  """
  describe "@businesses" do
    test "fetches all business by recommendations count",  %{business: business} do
      for _x <- 0..10, do: Businesses.recommend_business(business.id)

      assert {:ok, %{data: data}} = Absinthe.run(@businesses_doc, Schema, variables: %{"recommendations_count" => 10})
      assert List.first(data["businesses"])["id"] === to_string(business.id)
    end

    test "fetches all business by postcode", %{business: business} do
      assert {:ok, address} =
          Businesses.create_address(%{
          business_id: business.id,
          city: "test",
          country: "test",
          first_line: "test",
          postcode: "M50 3TY"
          })

        assert {:ok, %{data: data}} = Absinthe.run(@businesses_doc, Schema, variables: %{"postcode" => "M50 3TY"})

        business_response = List.first(data["businesses"])
        assert business_response["id"] === to_string(business.id)

        address_response = List.first(business_response["addresses"])
        assert address_response["id"] === to_string(address.id)
        assert address_response["postcode"] === "M50 3TY"
    end
  end
end
