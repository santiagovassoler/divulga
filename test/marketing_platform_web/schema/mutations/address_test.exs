defmodule DivulgaIoWeb.Schema.Mutations.AddressTest do
  alias DivulgaIo.Accounts
  use DivulgaIoWeb.DataCase, async: true

  alias DivulgaIo.Businesses
  alias DivulgaIoWeb.Schema

  setup do
    {:ok, user} = Accounts.create_user(%{email: "test@gmail.com", name: "Test"})
    {:ok, business} = Businesses.create_business(%{description: "description test", name: "test", user_id: user.id})

    {:ok, business: business}
  end

  @create_address_doc """
  mutation CreateAddress(
    $businessId: ID!,
    $city: String,
    $country: String,
    $firstLine: String,
    $secondLine: String,
    $postcode: String
    ) {
    createAddress(
      businessId: $businessId,
      city: $city,
      country: $country,
      firstLine: $firstLine,
      secondLine: $secondLine,
      postcode: $postcode
    ) {
      id
      postcode
    }
  }
  """

  describe "@createAddress" do
    test "create an Address", %{business: business} do
      postcode = "M50 3TY"

      assert {:ok, %{data: data}} =
               Absinthe.run(@create_address_doc, Schema,
                 variables: %{
                   "businessId" => business.id,
                   "city" => "Salford",
                   "country" => "England",
                   "firstLine" => "56, Test Street",
                   "postcode" => postcode
                 }
               )

      assert ^postcode = data["createAddress"]["postcode"]
    end
  end
end
