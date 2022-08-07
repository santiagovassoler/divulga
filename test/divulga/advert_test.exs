defmodule Divulga.AdvertTest do
  use Divulga.DataCase

  alias Divulga.Advert

  describe "businesses" do
    alias Divulga.Advert.Business

    @valid_attrs %{
      city: "some city",
      country: "some country",
      county: "some county",
      description: "some description",
      email: "some email",
      instagram_url: "some instagram_url",
      logo: "some logo",
      phone: "some phone",
      title: "some title",
      views: 42
    }
    @update_attrs %{
      city: "some updated city",
      country: "some updated country",
      county: "some updated county",
      description: "some updated description",
      email: "some updated email",
      instagram_url: "some updated instagram_url",
      logo: "some updated logo",
      phone: "some updated phone",
      title: "some updated title",
      views: 43
    }
    @invalid_attrs %{
      city: nil,
      country: nil,
      county: nil,
      description: nil,
      email: nil,
      instagram_url: nil,
      logo: nil,
      phone: nil,
      title: nil,
      views: nil
    }

    def business_fixture(attrs \\ %{}) do
      {:ok, business} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Advert.create_business()

      business
    end

    test "list_businesses/0 returns all businesses" do
      business = business_fixture()
      assert Advert.list_businesses() == [business]
    end

    test "get_business!/1 returns the business with given id" do
      business = business_fixture()
      assert Advert.get_business!(business.id) == business
    end

    test "create_business/1 with valid data creates a business" do
      assert {:ok, %Business{} = business} = Advert.create_business(@valid_attrs)
      assert business.city == "some city"
      assert business.country == "some country"
      assert business.county == "some county"
      assert business.description == "some description"
      assert business.email == "some email"
      assert business.instagram_url == "some instagram_url"
      assert business.logo == "some logo"
      assert business.phone == "some phone"
      assert business.title == "some title"
      assert business.views == 42
    end

    test "create_business/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Advert.create_business(@invalid_attrs)
    end

    test "update_business/2 with valid data updates the business" do
      business = business_fixture()
      assert {:ok, %Business{} = business} = Advert.update_business(business, @update_attrs)
      assert business.city == "some updated city"
      assert business.country == "some updated country"
      assert business.county == "some updated county"
      assert business.description == "some updated description"
      assert business.email == "some updated email"
      assert business.instagram_url == "some updated instagram_url"
      assert business.logo == "some updated logo"
      assert business.phone == "some updated phone"
      assert business.title == "some updated title"
      assert business.views == 43
    end

    test "update_business/2 with invalid data returns error changeset" do
      business = business_fixture()
      assert {:error, %Ecto.Changeset{}} = Advert.update_business(business, @invalid_attrs)
      assert business == Advert.get_business!(business.id)
    end

    test "delete_business/1 deletes the business" do
      business = business_fixture()
      assert {:ok, %Business{}} = Advert.delete_business(business)
      assert_raise Ecto.NoResultsError, fn -> Advert.get_business!(business.id) end
    end

    test "change_business/1 returns a business changeset" do
      business = business_fixture()
      assert %Ecto.Changeset{} = Advert.change_business(business)
    end
  end
end
