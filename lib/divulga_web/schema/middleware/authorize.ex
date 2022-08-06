defmodule DivulgaWeb.Schema.Middleware.Authorize do
  @behaviour Absinthe.Middleware

  def call(resolution, role) do
    with %{current_user: currenct_user} <- resolution.context,
         true <- correnct_role?(currenct_user, role) do
      resolution
    else
      _ ->
        resolution
        |> Absinthe.Resolution.put_result({:error, "Unauthorized"})
    end
  end

  defp correnct_role?(%{}, :any), do: true
  defp correnct_role?(%{role: role}, role), do: true
  defp correnct_role?(_, _), do: false
end
