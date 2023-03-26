defmodule EctoRange.TimestampTest do
  use EctoRange.Date.DataCase

  doctest EctoRange.Timestamp

  describe "cast/1" do
    test "it can take a Postgrex.Range.t()" do
      range = %Postgrex.Range{
        lower: ~N[2021-03-01 08:30:00],
        upper: ~N[2023-03-30 10:30:00],
        upper_inclusive: true,
        lower_inclusive: false
      }

      assert EctoRange.Timestamp.cast(range) == {:ok, range}
    end

    test "it can take a tuple" do
      range = {~N[2021-03-01 08:30:00], ~N[2023-03-30 10:30:00]}

      assert EctoRange.Timestamp.cast(range) ==
               {:ok,
                %Postgrex.Range{
                  lower: ~N[2021-03-01 08:30:00],
                  upper: ~N[2023-03-30 10:30:00],
                  upper_inclusive: true,
                  lower_inclusive: true
                }}
    end
  end
end
