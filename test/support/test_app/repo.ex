defmodule TestApp.Repo do
  use Ecto.Repo,
    otp_app: :ecto_range,
    adapter: Ecto.Adapters.Postgres
end
