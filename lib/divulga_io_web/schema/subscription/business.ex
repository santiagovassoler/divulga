defmodule DivulgaIoWeb.Schema.Subscription.Business do
  use Absinthe.Schema.Notation

  @recommendations_count_threshold [50, 100, 500, 1000]

  object :business_subscription do
    field :business_recommended, :business do
      config fn _, _ ->
        {:ok, topic: "recommendations_count"}
      end

      trigger :recommend_business, topic: fn business ->
        if business.recommendations_count in recommendations_count_threshold() do
          "recommendations_count"
        end
      end
    end
  end

  defp recommendations_count_threshold, do: @recommendations_count_threshold
end
