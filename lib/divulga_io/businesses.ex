defmodule DivulgaIo.Businesses do
  import Ecto.Query, warn: false
  alias EctoShorts.Actions
  alias DivulgaIo.Businesses.{Address, Campaign, Business}
  alias DivulgaIo.Repo

  def find_business(params) do
    case Actions.find(Business, params) do
      {:ok, business} -> {:ok, business}
      {:error, _} -> {:error, "No business with that id"}
    end
  end

  def list_business(params \\ %{}) do
    {:ok, Actions.all(Business, Business.filter_by(params))}
  end

  def create_business(params \\ %{}) do
    case Actions.create(Business, params) do
      {:ok, business} -> {:ok, business}
      {:error, _} -> {:error, "Could not create business"}
    end
  end

  def update_business(id, params) do
    case Actions.update(Business, id, params) do
      {:ok, business} -> {:ok, business}
      {:error, _} -> {:error, "no business with that id"}
    end
  end

  def recommend_business(id) do
    with {:ok, business} <- find_business(%{id: id}) do
      Actions.update(Business, business, %{recommendations_count: business.recommendations_count + 1})
    end
end

  def create_address(attrs \\ %{}) do
    case Actions.create(Address, attrs) do
      {:ok, address} -> {:ok, address}
      {:error, _} -> {:error, "Could not create address"}
    end
  end

  def create_campaign(attrs \\ %{}) do
    with :ok <- check_campaign_limit_not_exceeded(attrs) do
      case Actions.create(Campaign, attrs) do
        {:ok, campaign} -> {:ok, campaign}
        {:error, _} -> {:error, "Could not create campaign"}
      end
    end
  end

  def remove_campaign(id) do
    case Actions.delete(Campaign, id) do
      {:ok, _} -> {:ok, true}
      {:error, _} -> {:ok, false}
    end
  end

  def update_campaign(id, params) do
    case Actions.update(Campaign, id, params) do
      {:ok, campaign} -> {:ok, campaign}
      {:error, _} -> {:error, "no campaign with that id"}
    end
  end

  def find_campaign(params) do
    case Actions.find(Campaign, params) do
      {:ok, campaign} -> {:ok, campaign}
      {:error, _} -> {:error, "No active campaign with that id"}
    end
  end

  def find_and_inc_campaign_views(id) do
    with {:ok, campaign} <- find_campaign(%{id: id, is_active: true}) do
      Actions.update(Campaign, campaign, %{views_count: campaign.views_count + 1})
    end
  end

  def check_campaign_limit_not_exceeded(%{business_id: id}) do
    with {:ok, business} <- find_business(%{id: id}) do
      current_total = Actions.aggregate(Campaign, %{business_id: business.id, is_active: true}, :count, :id)
      total_allowed = Business.total_campaigns_allowed(business.recommendations_count)

      if current_total >= total_allowed do
        {:error, "Campaing limit exceeded"}
      else
        :ok
      end
    end
  end

  def check_campaign_limit_not_exceeded(_), do: {:error, "missing business_id key"}

  def deactivate_campaigns do
    end_date = NaiveDateTime.add(NaiveDateTime.utc_now(), -60 * 60 * 24 * 7)
    update_all(Campaign, %{is_active: true, end_date: end_date}, [set: [is_active: false]])
  end

  defp update_all(schema, query_params \\ %{}, update_params \\ [], options \\ []) do
    utc_now = NaiveDateTime.utc_now()
    update_params =
         Keyword.update(
           update_params,
           :set,
           [updated_at: utc_now],
           &Keyword.put(&1, :updated_at, utc_now)
         )

     schema
     |> EctoShorts.CommonFilters.convert_params_to_filter(query_params)
     |> Repo.update_all(update_params, options)
   end
  end
