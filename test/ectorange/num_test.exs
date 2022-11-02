defmodule EctoRange.NumTest do
  use EctoRange.Date.DataCase

  doctest EctoRange.Num

  describe "cast/1" do
    test "it can take a Postgrex.Range.t()" do
      range = %Postgrex.Range{
        lower: Decimal.new(1),
        upper: Decimal.new(3),
        upper_inclusive: true,
        lower_inclusive: false
      }

      assert EctoRange.Num.cast(range) == {:ok, range}
    end

    test "it can take a tuple" do
      range = {1, 3}

      assert EctoRange.Num.cast(range) ==
               {:ok,
                %Postgrex.Range{
                  lower: Decimal.new(1),
                  upper: Decimal.new(3),
                  upper_inclusive: true,
                  lower_inclusive: true
                }}
    end

    test "it can take floats" do
      range = {1.1, 3.3}

      assert EctoRange.Num.cast(range) ==
               {:ok,
                %Postgrex.Range{
                  lower: Decimal.from_float(1.1),
                  upper: Decimal.from_float(3.3),
                  upper_inclusive: true,
                  lower_inclusive: true
                }}
    end

    test "it errors on non-numeric values" do
      range = {"foo", "bar"}

      assert EctoRange.Num.cast(range) == :error
    end
  end

  describe "normalize_range/1" do
    test "it adds and subtracts the smallest float amount possible for unbounded ranges" do
      range = %Postgrex.Range{
        lower: 1.0,
        upper: 2.0,
        upper_inclusive: false,
        lower_inclusive: false
      }

      assert EctoRange.Num.normalize_range(range) ==
               %Postgrex.Range{
                 lower: Decimal.from_float(1.000000001),
                 upper: Decimal.from_float(1.999999999),
                 upper_inclusive: true,
                 lower_inclusive: true
               }
    end
  end
end
