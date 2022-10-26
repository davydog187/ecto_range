defmodule Ecto.Int8RangeTest do
  use Ecto.DateRange.DataCase

  doctest Ecto.Int8Range

  describe "cast/1" do
    test "it can take a Postgrex.Range.t()" do
      range = %Postgrex.Range{
        lower: 1,
        upper: 3,
        upper_inclusive: true,
        lower_inclusive: false
      }

      assert Ecto.Int8Range.cast(range) == {:ok, range}
    end

    test "it can take a tuple" do
      range = {1, 3}

      assert Ecto.Int8Range.cast(range) ==
               {:ok,
                %Postgrex.Range{
                  lower: 1,
                  upper: 3,
                  upper_inclusive: true,
                  lower_inclusive: true
                }}
    end

    test "it blocks values not in the Int8 range" do
      range = %Postgrex.Range{
        lower: -9_223_372_036_854_775_809,
        upper: 9_223_372_036_854_775_808,
        upper_inclusive: true,
        lower_inclusive: false
      }

      assert Ecto.Int8Range.cast(range) == :error
    end
  end
end
