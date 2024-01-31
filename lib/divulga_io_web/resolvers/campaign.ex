defmodule DivulgaIoWeb.Resolvers.Campaign do
  alias DivulgaIo.Businesses
  alias DivulgaIo.Domain.Campaign.DescriptionSummarizer

  def create_campaign(params, _) do
    with {:ok, campaign} <- Businesses.create_campaign(params) do
      Task.Supervisor.start_child(DivulgaIo.TaskSupervisor, fn ->
        DescriptionSummarizer.update_description(campaign.id, campaign.description)
      end)
      {:ok, campaign}
    end
  end

  def find_campaign(%{id: id}, _) do
    id = String.to_integer(id)
    Businesses.find_and_inc_campaign_views(id)
  end

  def remove_campaign(%{id: id}, _) do
    id = String.to_integer(id)
    Businesses.remove_campaign(id)
  end

end
