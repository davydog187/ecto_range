defmodule Ecto.Int4rangeTest do
  use Ecto.DateRange.DataCase

  describe "cast/1" do
    test "it can take a Postgrex.Range.t()" do
      range = %Postgrex.Range{
        lower: 1,
        upper: 3,
        upper_inclusive: true,
        lower_inclusive: false
      }

      assert Ecto.Int4range.cast(range) == {:ok, range}
    end

    test "it can take a tuple" do
      range = {1, 3}

      assert Ecto.Int4range.cast(range) ==
               {:ok,
                %Postgrex.Range{
                  lower: 1,
                  upper: 3,
                  upper_inclusive: true,
                  lower_inclusive: true
                }}
    end

    test "it blocks values not in the Int4 range" do
      range = %Postgrex.Range{
        lower: -2_147_483_649,
        upper: 2_147_483_648,
        upper_inclusive: true,
        lower_inclusive: false
      }

      assert Ecto.Int4range.cast(range) == :error
    end
  end
end
