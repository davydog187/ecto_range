defmodule EctoRange.Int8Test do
  use EctoRange.Date.DataCase

  doctest EctoRange.Int8

  describe "cast/1" do
    test "it can take a Postgrex.Range.t()" do
      range = %Postgrex.Range{
        lower: 1,
        upper: 3,
        upper_inclusive: true,
        lower_inclusive: false
      }

      assert EctoRange.Int8.cast(range) == {:ok, range}
    end

    test "it can take a tuple" do
      range = {1, 3}

      assert EctoRange.Int8.cast(range) ==
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

      assert EctoRange.Int8.cast(range) == :error
    end
  end
end
