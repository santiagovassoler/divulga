defmodule DivulgaIo.Domain.Campaign.DeactivatorTest do
  use DivulgaIoWeb.DataCase, async: true
  alias DivulgaIo.Domain.Campaign.Deactivator
  alias DivulgaIo.{Accounts, Businesses}
  alias DivulgaIo.Businesses.Campaign
  alias EctoShorts.Actions

  setup do
    {:ok, user} = Accounts.create_user(%{email: "test@gmail.com", name: "Test"})
    {:ok, business} = Businesses.create_business(%{description: "description test", name: "test", user_id: user.id})
    {:ok, business} = Businesses.update_business(business.id, %{recommendations_count: 999})

    for x <- 0..3 do
      Businesses.create_campaign(%{business_id: business.id, slug: "test-slug-#{x}", description: "test description"})
    end

    Repo.update_all(
      from(c in Campaign, where: c.is_active == true),
        set: [inserted_at: NaiveDateTime.add(NaiveDateTime.utc_now(), -60 * 60 * 24 * 7)]
      )

    {:ok, business: business}
  end

  describe "&deactivate_campaigns/0" do
    test "deactivate all campaigns", %{business: business} do
      campaigns = Actions.all(Campaign, %{business_id: business.id})
      Enum.each(campaigns, fn (campaing) -> assert true === campaing.is_active end)

      Deactivator.deactivate_campaigns()

      campaigns = Actions.all(Campaign, %{business_id: business.id})
      Enum.each(campaigns, fn (campaing) -> assert false === campaing.is_active end)
    end
  end
end
