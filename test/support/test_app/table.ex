defmodule TestApp.Table do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  schema "my_table" do
    field(:name, :string)
    field(:range, Ecto.DateRange)
    field(:int4range, Ecto.Int4Range)
    field(:int8range, Ecto.Int8Range)
    field(:numrange, Ecto.NumRange)
  end

  def changeset(table, params) do
    table
    |> cast(params, [:name, :range, :int4range, :int8range, :numrange])
    |> validate_required([:name])
  end
end
