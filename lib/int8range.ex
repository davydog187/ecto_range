defmodule Ecto.Int8Range do
  @moduledoc """
  A Postgres range of `int8` integers. Equivalent to `int8range`.
  """

  use Ecto.Type

  @int8_range -9_223_372_036_854_775_808..9_223_372_036_854_775_807

  @impl Ecto.Type
  def type, do: :int8range

  @impl Ecto.Type
  def cast(%Postgrex.Range{lower: lower, upper: upper} = range)
      when lower in @int8_range and upper in @int8_range do
    {:ok, to_postgrex_range(range)}
  end

  def cast({lower, upper})
      when lower in @int8_range and upper in @int8_range do
    {:ok, to_postgrex_range({lower, upper})}
  end

  def cast(_), do: :error

  @impl Ecto.Type
  def dump(%Postgrex.Range{} = range) do
    {:ok, range}
  end

  def dump(_), do: :error

  @impl Ecto.Type
  def load(%Postgrex.Range{} = range) do
    {:ok, normalize_range(range)}
  end

  @doc """
  Checks and converts a `Postgrex.Range` or tuple into a `Postgrex.Range.t()`

  ## Examples

      iex> Ecto.DateRange.to_postgrex_range({1, 3})
      %Postgrex.Range{lower: 1, upper: 3, lower_inclusive: true, upper_inclusive: true}

  """
  @spec to_postgrex_range(Postgrex.Range.t() | {integer(), integer()}) ::
          Postgrex.Range.t()
  def to_postgrex_range(%Postgrex.Range{} = range), do: range

  def to_postgrex_range({lower, upper}) do
    %Postgrex.Range{
      lower: if(is_nil(lower), do: :unbound, else: lower),
      upper: if(is_nil(upper), do: :unbound, else: upper),
      lower_inclusive: true,
      upper_inclusive: true
    }
  end

  @doc """
  Converts a Postgrex.Range.t() into a normalized form. For bounded ranges,
  it will make the lower and upper bounds inclusive.

      iex> range = %Postgrex.Range{lower: 1, upper: 3, lower_inclusive: true, upper_inclusive: false}
      iex> Ecto.Int4Range.normalize_range(range)
      %Postgrex.Range{lower: 1, upper: 2, lower_inclusive: true, upper_inclusive: true}

      iex> range = %Postgrex.Range{lower: 1, upper: 3, lower_inclusive: false, upper_inclusive: true}
      iex> Ecto.Int4Range.normalize_range(range)
      %Postgrex.Range{lower: 2, upper: 3, lower_inclusive: true, upper_inclusive: true}

  """
  def normalize_range(%Postgrex.Range{lower: lower, upper: upper} = range)
      when is_integer(lower) and is_integer(upper) do
    range
    |> normalize_upper()
    |> normalize_lower()
  end

  def normalize_range(%Postgrex.Range{} = range), do: range

  defp normalize_upper(%Postgrex.Range{} = range) do
    if range.upper_inclusive do
      range
    else
      %{range | upper_inclusive: true, upper: range.upper - 1}
    end
  end

  defp normalize_lower(%Postgrex.Range{} = range) do
    if range.lower_inclusive do
      range
    else
      %{range | lower_inclusive: true, lower: range.lower + 1}
    end
  end
end
