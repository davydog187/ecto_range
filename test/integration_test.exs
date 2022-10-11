defmodule EctoDateRange.IntegrationTest do
  use Ecto.DateRange.DataCase

  alias TestApp.Table

  test "can round trip data through the database" do
    range = Date.range(~D[1989-09-22], ~D[2021-03-01])

    assert %Table{id: id} = TestApp.Repo.insert!(%Table{name: "a", foo: range})

    assert %TestApp.Table{foo: ^range, id: ^id, name: "a"} = TestApp.Repo.get!(Table, id)
  end
end
