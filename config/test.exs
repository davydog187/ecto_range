import Config

config :ecto_range, :ecto_repos, [TestApp.Repo]

config :ecto_range, TestApp.Repo,
  pool: Ecto.Adapters.SQL.Sandbox,
  database: "test_app_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
