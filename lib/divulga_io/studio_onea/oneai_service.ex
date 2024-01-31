defmodule DivulgaIo.StudioOnea.OneaiService do

  def call(input, opts \\ []) do
    %{
      "input" => input,
      "input_type" => "article",
      "output_type" => "json",
      "multilingual" => %{
        "enabled" => true
      },
      "steps" => [%{
        "skill" => "summarize"
      }]
    }
    |> Jason.encode!()
    |> request(opts)
    |> parse_response()
  end

  defp parse_response({:ok, %Finch.Response{status: 200, body: body}}) do
    utterance =
      body
        |> Jason.decode!()
        |> Map.get("output")
        |> List.first
        |> Map.get("contents")
        |> List.first
        |> Map.get("utterance")

        {:ok, utterance}
  end

  defp parse_response({:ok, %Finch.Response{status: status, body: body}}) do
    message =
      body
      |> Jason.decode!()
      |> Map.get("message")

    {:error, %{status: status, message: message }}
  end

  defp parse_response({:error, %Mint.TransportError{reason: reason}}) do
    {:error, %{status: 400, message: reason }}
  end

  defp request(body, _opts) do
    :post
    |> Finch.build("https://api.oneai.com/api/v0/pipeline", headers(), body)
    |> Finch.request(DivulgaIo.Finch)
  end

  defp headers do
    [
      {"content-type", "application/json"},
      {"api-key", Application.get_env(:divulga_io, :studio_onea_api_key)},
    ]
  end
end
