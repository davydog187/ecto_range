defmodule TestApp.Repo do
  use Ecto.Repo,
    otp_app: :ectorange,
    adapter: Ecto.Adapters.Postgres
end
