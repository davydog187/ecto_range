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
  end

  describe "dump/1" do
  end

  describe "embed_as/1" do
  end

  describe "equal?/2" do
  end

  describe "load/1" do
  end
end
