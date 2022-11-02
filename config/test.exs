import Config

config :ectorange, :ecto_repos, [TestApp.Repo]

config :ectorange, TestApp.Repo,
  pool: Ecto.Adapters.SQL.Sandbox,
  database: "test_app_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
