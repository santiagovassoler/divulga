defmodule DivulgaIoWeb.Schema.Subscription.BusinessTest do
  alias DivulgaIo.{Accounts, Businesses}
  use DivulgaIoWeb.SubscriptionCase

  setup context do
    Ecto.Adapters.SQL.Sandbox.checkout(DivulgaIo.Repo)
    {:ok, user} = Accounts.create_user(%{email: "test@gmail.com", name: "Test"})
    {:ok, business} = Businesses.create_business(%{description: "description test", name: "test", user_id: user.id})

    {:ok, Map.put(context, :business, business)}
  end

  @recommendations_count_threshold [50, 100, 500, 1000]

  @recommend_business_doc """
    mutation RecommendBusiness($id: ID!){
      recommendBusiness(id: $id){
        id
        name
        recommendationsCount
      }
    }
  """

  @business_recommended_sub_doc """
    subscription BusinessRecommended {
      businessRecommended {
        id
        name
        recommendationsCount
      }
    }
  """

  describe "@businessRecommended" do
    test "triggers when recommendations count reaches 50", %{socket: socket, business: business} do

      {:ok, business} = Businesses.update_business(business.id, %{recommendations_count: 49})

      ref = push_doc(socket, @business_recommended_sub_doc)
      assert_reply ref, :ok, %{subscriptionId: subscription_id}

      ref = push_doc(socket, @recommend_business_doc, variables: %{id: business.id})
      assert_reply ref, :ok, reply

      id = to_string(business.id)

      assert %{
        data: %{
          "recommendBusiness" => %{
            "id" => ^id,
            "name" => "test",
            "recommendationsCount" => 50
          }
        }
      } = reply

      expected_payload = %{
        subscriptionId: subscription_id,
        result: %{
          data: %{
            "businessRecommended" => %{
              "id" => id,
              "name" => "test",
              "recommendationsCount" => 50,
            }
          }
        }
      }
      assert_push "subscription:data", ^expected_payload
    end

    test "does not trigger topic recommendations_count", %{socket: socket, business: business} do
      refute business.recommendations_count in @recommendations_count_threshold

      ref = push_doc(socket, @business_recommended_sub_doc)
      assert_reply ref, :ok, %{subscriptionId: subscription_id}

      ref = push_doc(socket, @recommend_business_doc, variables: %{id: business.id})
      assert_reply ref, :ok, reply

      id = to_string(business.id)

      assert %{
        data: %{
          "recommendBusiness" => %{
            "id" => ^id,
            "name" => "test",
            "recommendationsCount" => 1
          }
        }
      } = reply

      expected_payload = %{
        subscriptionId: subscription_id,
        result: %{
          data: %{
            "businessRecommended" => %{
              "id" => id,
              "name" => "test",
              "recommendationsCount" => 1,
            }
          }
        }
      }
      refute_push "subscription:data", ^expected_payload
    end
  end

end
