defmodule TestApp.Table do
  use Ecto.Schema

  schema "my_table" do
    field(:name, :string)
    field(:foo, Ecto.DateRange)
  end
end
