# EctoRange.Date

[![Build Status](https://github.com/bitfo/ectorange/workflows/CI/badge.svg?branch=main)](https://github.com/bitfo/ectorange/actions) [![Hex pm](https://img.shields.io/hexpm/v/ectorange.svg?style=flat)](https://hex.pm/packages/ectorange) [![Hexdocs.pm](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/ectorange/)

<!-- MDOC !-->

`EctoRange.DateRange` is a tiny library that provides an Ecto custom type for `Date.` and the underlying [daterange](https://www.postgresql.org/docs/14/rangetypes.html#RANGETYPES-BUILTIN) postgres type.

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
