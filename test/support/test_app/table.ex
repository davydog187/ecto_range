defmodule TestApp.Table do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  schema "my_table" do
    field(:name, :string)
    field(:range, Ecto.DateRange)
  end

  def changeset(table, params) do
    table
    |> cast(params, [:name, :range])
    |> validate_required([:name, :range])
  end
end
