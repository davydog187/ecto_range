defmodule TestApp.Table do
  @moduledoc false
  use Ecto.Schema

  schema "my_table" do
    field(:name, :string)
    field(:foo, Ecto.DateRange)
  end
end
