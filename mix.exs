defmodule EctoRange.MixProject do
  use Mix.Project

  @url "http://github.com/davydog187/ecto_range"
  @version "0.1.0"

  def project do
    [
      aliases: aliases(),
      app: :ecto_range,
      version: @version,
      elixir: "~> 1.14",
      package: package(),
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      description: "Ecto support for Postgres Range types",
      deps: deps(),
      docs: docs()
    ]
  end

  defp elixirc_paths(:test), do: elixirc_paths(:dev) ++ ["test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp docs do
    [
      main: "EctoRange",
      source_url: @url,
      source_ref: "v#{@version}",
      extras: []
    ]
  end

  defp package do
    [
      licenses: ["Apache-2.0"],
      maintainers: ["davydog187"],
      links: %{"Github" => @url}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:ecto, "~> 3.6"},
      {:ecto_sql, "~> 3.9", only: [:test]},
      {:postgrex, "~> 0.16.5"},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
