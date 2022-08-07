defmodule DivulgaWeb.Schema.Middleware.Authorize do
  @behaviour Absinthe.Middleware

  def call(resolution, role) do
    with %{user: user} <- resolution.context,
         true <- correct_role?(user, role) do
      resolution
    else
      _ ->
        resolution
        |> Absinthe.Resolution.put_result({:error, "unauthorized"})
    end
  end

  defp correct_role?(%{}, :any), do: true

  defp correct_role?(%{role: role}, given_role) do
    role = String.to_atom(role)

    case role == given_role || role == :admin do
      true -> true
      _ -> false
    end
  end

  defp correct_role?(_, _), do: false
end
