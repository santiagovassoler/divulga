defmodule DivulgaIoWeb.Schema.Queries.CampaignTest do
  alias DivulgaIo.Accounts
  use DivulgaIoWeb.DataCase, async: true

  alias DivulgaIo.Businesses
  alias DivulgaIoWeb.Schema

  setup do
    {:ok, user} = Accounts.create_user(%{email: "test@gmail.com", name: "Test"})
    {:ok, business} = Businesses.create_business(%{description: "description test", name: "test", user_id: user.id})
    {:ok, campaign} = Businesses.create_campaign(%{business_id: business.id, slug: "test-slug", description: "test description"})

    {:ok, campaign: campaign}
  end

  @campaign_doc """
  query Campaign($id: ID!) {
    campaign(id: $id) {
      id
      slug
      viewsCount
      description
    }
  }
  """

  describe "@campaign" do
    test "fetches campaign by id & increase views count",  %{campaign: campaign} do
      assert campaign.views_count === 0
      assert {:ok, %{data: data}} = Absinthe.run(@campaign_doc, Schema, variables: %{"id" => campaign.id})
      assert data["campaign"]["id"] === to_string(campaign.id)
      assert data["campaign"]["viewsCount"] === 1
    end

    test "fetches campaign by id returns empty" do
      assert {:ok, %{data: data}} = Absinthe.run(@campaign_doc, Schema, variables: %{"id" => 100})
      assert data["campaign"] === nil
    end
  end

end
