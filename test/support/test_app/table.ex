defmodule TestApp.Table do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  schema "my_table" do
    field(:name, :string)
    field(:range, EctoRange.Date)
    field(:int4range, EctoRange.Int4)
    field(:int8range, EctoRange.Int8)
    field(:numrange, EctoRange.Num)
  end

  def changeset(table, params) do
    table
    |> cast(params, [:name, :range, :int4range, :int8range, :numrange])
    |> validate_required([:name])
  end
end
