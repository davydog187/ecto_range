# EctoRange

[![Build Status](https://github.com/bitfo/ectorange/workflows/CI/badge.svg?branch=main)](https://github.com/bitfo/ectorange/actions) [![Hex pm](https://img.shields.io/hexpm/v/ectorange.svg?style=flat)](https://hex.pm/packages/ectorange) [![Hexdocs.pm](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/ectorange/)

<!-- MDOC !-->

`EctoRange` is a tiny library that provides Ecto custom types for all [Postgres Range types](https://www.postgresql.org/docs/current/rangetypes.html).

| Postgres type | `Ecto.Type`               |
| ------------- | ------------------------- |
| int4range     | `EctoRange.Int4`          |
| int8range     | `EctoRange.Int8`          |
| numrange      | `EctoRange.Num`           |
| tsrange       | `EctoRange.NaiveDatetime` |
| tstzrange     | `EctoRange.Datetime`      |

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ectorange` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ectorange, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/ectorange>.
