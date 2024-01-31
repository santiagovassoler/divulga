defmodule DivulgaIoWeb.Schema.Mutations.CampaignTest do
  alias DivulgaIo.Accounts
  use DivulgaIoWeb.DataCase, async: true

  alias DivulgaIo.Businesses
  alias DivulgaIoWeb.Schema

  setup do
    {:ok, user} = Accounts.create_user(%{email: "test@gmail.com", name: "Test"})
    {:ok, business} = Businesses.create_business(%{description: "description test", name: "test", user_id: user.id})

    {:ok, business: business}
  end

  @create_campaign_doc """
    mutation CreateCampaign($businessId: ID!, $slug: String!, $description: String!){
      createCampaign(businessId: $businessId, slug: $slug, description: $description){
        id
        slug
        description
      }
    }
  """

  describe "@createCampaign" do
    test "create campaign for a business", %{business: business} do

      assert {:ok, %{data: data}} =
               Absinthe.run(@create_campaign_doc, Schema,
                 variables: %{
                   "businessId" => business.id,
                   "slug" => "christmas-sale",
                   "description" => "christmas sale - 50% off!!",
                 }
               )

      assert data["createCampaign"]["slug"] === "christmas-sale"
    end

    test "does not create campaign, limit exceeded", %{business: business} do

      assert {:ok, %{data: data}} =
               Absinthe.run(@create_campaign_doc, Schema,
                 variables: %{
                   "businessId" => business.id,
                   "slug" => "christmas-sale",
                   "description" => "christmas sale - 50% off!!",
                 }
               )

      assert data["createCampaign"]["slug"] === "christmas-sale"

      assert {:ok, %{data: data, errors: errors}} =
        Absinthe.run(@create_campaign_doc, Schema,
          variables: %{
            "businessId" => business.id,
            "slug" => "christmas-sale",
            "description" => "christmas sale - 50% off!!",
          }
        )
      assert data["createCampaign"] === nil
      assert List.first(errors)[:message] === "Campaing limit exceeded"
    end
  end

  @remove_campaign_doc """
    mutation RemoveCampaign($id: ID!){
      removeCampaign(id: $id)
    }
  """

  describe "@removeCampaign" do
    test "remove campaign by id returns true", %{business: business} do

    assert {:ok, campaign} =
      Businesses.create_campaign(%{
        business_id: business.id,
        slug: "christmas-sale",
        description: "christmas sale - 50% off!!",
    })

      assert {:ok, %{data: data}} =
               Absinthe.run(@remove_campaign_doc, Schema,
                 variables: %{
                   "id" => campaign.id,
                 }
               )

      assert %{"removeCampaign" => true} === data
    end

    test "remove campaign by id returns false" do

      assert {:ok, %{data: data}} =
                Absinthe.run(@remove_campaign_doc, Schema,
                  variables: %{
                    "id" => "999",
                  }
                )

      assert %{"removeCampaign" => false} === data
      end
  end
end
