defmodule Divulga.Accounts.Session do
  alias Divulga.Accounts.User
  alias Divulga.Repo

  def authenticate(args) do
    user = Repo.get_by(User, email: String.downcase(args.email))

    case check_password(user, args) do
      {:ok, user} -> {:ok, user}
      _ -> {:error, "Incorrect login credentials"}
    end
  end

  defp check_password(nil, _) do
    Argon2.no_user_verify()
  end

  defp check_password(user, args) do
    Argon2.check_pass(user, args.password, hash_key: :password_hash)
  end
end
