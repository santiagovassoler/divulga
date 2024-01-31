defmodule DivulgaIo.Repo do
  use Ecto.Repo,
    otp_app: :divulga_io,
    adapter: Ecto.Adapters.Postgres
end
