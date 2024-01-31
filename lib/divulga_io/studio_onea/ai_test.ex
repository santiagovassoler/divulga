defmodule DivulgaIo.StudioOnea.AiTest do
  def call("old description"), do: {:ok, "New description returned"}
  def call(_), do: {:error, %{status: 401, message: "API key not found" }}
end
