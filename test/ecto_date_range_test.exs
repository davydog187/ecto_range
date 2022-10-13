defmodule EctoDateRangeTest do
  use ExUnit.Case
  doctest Ecto.DateRange

  describe "cast/1" do
    test "it can take Date.Range.t()" do
      range = Date.range(~D[1989-09-22], ~D[2021-03-01])

      assert Ecto.DateRange.cast(range) ==
               {:ok,
                %Postgrex.Range{
                  lower: ~D[1989-09-22],
                  upper: ~D[2021-03-01],
                  lower_inclusive: true,
                  upper_inclusive: true
                }}
    end

    test "it can take Postgrex.Range.t()" do
      range = %Postgrex.Range{
        lower: ~D[1989-09-22],
        upper: ~D[2021-03-01],
        upper_inclusive: true,
        lower_inclusive: false
      }

      assert Ecto.DateRange.cast(range) == {:ok, range}
    end

    test "it can take date tuples" do
      range = {~D[1989-09-22], ~D[2021-03-01]}

      assert Ecto.DateRange.cast(range) ==
               {:ok,
                %Postgrex.Range{
                  lower: ~D[1989-09-22],
                  upper: ~D[2021-03-01],
                  lower_inclusive: true,
                  upper_inclusive: true
                }}

      range = {~D[1989-09-22], nil}

      assert Ecto.DateRange.cast(range) ==
               {:ok,
                %Postgrex.Range{
                  lower: ~D[1989-09-22],
                  upper: :unbound,
                  lower_inclusive: true,
                  upper_inclusive: true
                }}
    end

    test "it can take string tuples" do
      range = {"1989-09-22", "2021-03-01"}

      assert Ecto.DateRange.cast(range) ==
               {:ok,
                %Postgrex.Range{
                  lower: ~D[1989-09-22],
                  upper: ~D[2021-03-01],
                  lower_inclusive: true,
                  upper_inclusive: true
                }}

      range = {"1989-09-22", nil}

      assert Ecto.DateRange.cast(range) ==
               {:ok,
                %Postgrex.Range{
                  lower: ~D[1989-09-22],
                  upper: :unbound,
                  lower_inclusive: true,
                  upper_inclusive: true
                }}

      # treat empty string as nil
      range = {"", "2021-03-01"}

      assert Ecto.DateRange.cast(range) ==
               {:ok,
                %Postgrex.Range{
                  lower: :unbound,
                  upper: ~D[2021-03-01],
                  lower_inclusive: true,
                  upper_inclusive: true
                }}
    end

    test "invalid dates are errors" do
      assert Ecto.DateRange.cast({"09-22-1989", "2021-03-01"}) == :error
      assert Ecto.DateRange.cast({nil, "blah"}) == :error
    end
  end

  describe "dump/1" do
  end

  describe "load/1" do
  end
end
