defmodule DivulgaIo.Domain.Campaign.DescriptionSummarizerTest do
  alias DivulgaIo.{Accounts, Businesses}
  alias DivulgaIo.Domain.Campaign.DescriptionSummarizer
  use DivulgaIoWeb.DataCase, async: true

  setup do
    {:ok, user} = Accounts.create_user(%{email: "test@gmail.com", name: "Test"})
    {:ok, business} = Businesses.create_business(%{description: "description test", name: "test", user_id: user.id})
    {:ok, campaign} = Businesses.create_campaign(%{business_id: business.id, slug: "test-slug", description: "old description"})
    Ecto.Adapters.SQL.Sandbox.checkout(DivulgaIo.Repo)
    {:ok, campaign: campaign}
  end

  describe "&update_description/2" do

    test "updates campaign with new description", %{campaign: campaign} do
      assert {:ok, campaign} = DescriptionSummarizer.update_description(campaign.id, campaign.description)
      assert campaign.description === "New description returned"
    end

    test "skips the update if API returns an error",  %{campaign: campaign} do
      assert {:error, result} = DescriptionSummarizer.update_description(campaign.id, "invalid")
      assert campaign.description === "old description"
      assert result.message === "API key not found"
      assert result.status === 401
    end

    test "skips the update if campaign id is not found" do
      assert {:error, message} = DescriptionSummarizer.update_description("999", "old description")
      assert message === "no campaign with that id"
    end
  end
end
