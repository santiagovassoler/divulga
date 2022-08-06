defmodule Divulga.Guardian do
  use Guardian, otp_app: :divulga
  alias Divulga.Accounts

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(%{"sub" => id}) do
    user = Accounts.get_user!(id)
    {:ok, user}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end
