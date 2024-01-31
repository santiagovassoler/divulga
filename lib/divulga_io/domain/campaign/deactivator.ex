defmodule DivulgaIo.Domain.Campaign.Deactivator do
  alias DivulgaIo.Businesses
  def deactivate_campaigns, do: Businesses.deactivate_campaigns()
end
