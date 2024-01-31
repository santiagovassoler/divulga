defmodule DivulgaIo.Workers.CampaignDeactivatior do
  use Task
  require Logger
  alias DivulgaIo.Domain.Campaign.Deactivator

  @interval 24 * 60 * 60 * 1000

  def start_link(_arg), do: Task.start_link(&loop/0)

  defp loop do
    Deactivator.deactivate_campaigns()
    :timer.sleep(@interval)
    loop()
  end
end
