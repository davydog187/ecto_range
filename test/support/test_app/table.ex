defmodule TestApp.Table do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  schema "my_table" do
    field(:name, :string)
    field(:range, Ecto.DateRange)
    field(:int4range, Ecto.Int4Range)
  end

  def changeset(table, params) do
    table
    |> cast(params, [:name, :range, :int4range])
    |> validate_required([:name])
  end
end
