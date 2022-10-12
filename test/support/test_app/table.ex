defmodule TestApp.Table do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  schema "my_table" do
    field(:name, :string)
    field(:foo, Ecto.DateRange)
  end

  def changeset(table, params) do
    table
    |> cast(params, [:name, :foo])
    |> validate_required([:name, :foo])
  end
end
