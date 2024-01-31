defmodule DivulgaIo.Domain.Campaign.DescriptionSummarizer do
  alias DivulgaIo.Businesses
  alias DivulgaIo.StudioOnea.OneaiService

  def update_description(id, description) do
    with {:ok, description} <- ai_service().call(description) do
      Businesses.update_campaign(id, %{description: description})
    end
  end

  defp ai_service, do: Application.get_env(:divulga_io, :ai_service, OneaiService)
end
