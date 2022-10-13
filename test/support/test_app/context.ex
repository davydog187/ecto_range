defmodule TestApp.Context do
  alias TestApp.Table
  alias TestApp.Repo

  def create_table(attrs) do
    %Table{}
    |> Table.changeset(attrs)
    |> Repo.insert()
  end
end
