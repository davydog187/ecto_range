# Ecto.DateRange

[![Build Status](https://github.com/bitfo/ecto_date_range/workflows/CI/badge.svg?branch=main)](https://github.com/bitfo/ecto_date_range/actions) [![Hex pm](https://img.shields.io/hexpm/v/ecto_date_range.svg?style=flat)](https://hex.pm/packages/ecto_date_range) [![Hexdocs.pm](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/ecto_date_range/)

<!-- MDOC !-->

`Ecto.DateRange` is a tiny library that provides an Ecto custom type for `Date.Range` and the underlying [daterange](https://www.postgresql.org/docs/14/rangetypes.html#RANGETYPES-BUILTIN) postgres type.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ecto_date_range` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ecto_date_range, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/ecto_date_range>.
