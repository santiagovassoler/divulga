defmodule DivulgaWeb.Plugs.Context do
  @behaviour Plug
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    case build_context(conn) do
      {:ok, context} ->
        put_private(conn, :absinthe, %{context: context})

      {:error, reason} ->
        conn
        |> send_resp(403, reason)
        |> halt()

      _ ->
        conn
        |> send_resp(400, "Bad Request")
        |> halt()
    end
  end

  defp build_context(conn) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token] ->
        with {:ok, user, _} <- Divulga.Guardian.resource_from_token(token) do
          {:ok, %{user: user}}
        else
          _ ->
            {:ok, %{user: nil}}
        end

      _ ->
        {:ok, %{user: nil}}
    end
  end
end
