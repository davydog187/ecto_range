# EctoRange

[![Build Status](https://github.com/bitfo/ectorange/workflows/CI/badge.svg?branch=main)](https://github.com/bitfo/ectorange/actions) [![Hex pm](https://img.shields.io/hexpm/v/ecto_range.svg?style=flat)](https://hex.pm/packages/ecto_range) [![Hexdocs.pm](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/ecto_range/) [Changelog](https://github.com/davydog187/ecto_range/blob/main/CHANGELOG.md)

<!-- MDOC !-->

`EctoRange` is a tiny library that provides Ecto custom types for all [Postgres Range types](https://www.postgresql.org/docs/current/rangetypes.html).

The main design goal of `EctoRange` is to be easy to use with native Elixir types,
while providing the full flexibility of Postgres Range types inside of Ecto.

| Postgres type | `Ecto.Type`             |
| ------------- | ----------------------- |
| int4range     | `EctoRange.Int4`        |
| int8range     | `EctoRange.Int8`        |
| numrange      | `EctoRange.Num`         |
| tsrange       | `EctoRange.Timestamp`   |
| tstzrange     | `EctoRange.TimestampTZ` |
| daterange     | `EctoRange.Date`        |

## Usage

`EctoRange` provides custom types, and can be used like any other Ecto type.

```elixir
defmodule MyApp.Repo.Migrations.AddRange do
  use Ecto.Migration

  def change do
    create table(:my_table) do
      add :name, :string
      add :range, :daterange
    end
  end
end

defmodule MyApp.Table do
  use Ecto.Schema

  import Ecto.Changeset

  schema "my_table" do
    field(:name, :string)
    field(:range, EctoRange.Date)
  end

  def changeset(table, params) do
    table
    |> cast(params, [:name, :range])
    |> validate_required([:name, :range])
  end
end

iex> alias MyApp.Table

iex> range = Date.range(~D[1989-09-22], ~D[2021-03-01])

iex> cs = Table.changeset(%Table{}, %{name: "table", range: range})

iex> cs.changes
%Ecto.Changeset{
  changes: %{
    range: %Postgrex.Range{
      lower: ~D[1989-09-22],
      upper: ~D[2021-03-01],
      lower_inclusive: true,
      upper_inclusive: true
    },
    name: "name"
  },
  data: %MyApp.Table{id: nil, name: nil, range: nil},
  params: %{
    "range" => Date.range(~D[1989-09-22], ~D[2021-03-01]),
    "name" => "name"
  },
  valid?: true
}
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ectorange` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ecto_range, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/ectorange>.

## Alternative libraries

If you're unhappy with the feature set`EctoRange`, there are some alternative libraries that provide similar functionality

- [ecto_date_time_range](https://github.com/synchronal/ecto_date_time_range)
- [pg_ranges](https://github.com/vforgione/pg_ranges)
