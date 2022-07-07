defmodule Divulga.Repo do
  use Ecto.Repo,
    otp_app: :divulga,
    adapter: Ecto.Adapters.Postgres
end
