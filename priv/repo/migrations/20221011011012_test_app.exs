defmodule TestApp.Repo.Migrations.TestApp do
  use Ecto.Migration

  def change do
    create table(:my_table) do
      add :name, :string
      add :foo, :daterange
    end
  end
end
