defmodule Ecto.Int4range do
  use Ecto.Type

  @int4_range -2_147_483_648..2_147_483_647

  @impl Ecto.Type
  def type, do: :int4range

  @impl Ecto.Type
  def cast(%Postgrex.Range{} = range) do
    to_postgrex_range(range)
  end

  def cast({lower, upper}) do
    to_postgrex_range({lower, upper})
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

  defp to_postgrex_range(%Postgrex.Range{lower: lower, upper: upper} = range)
       when lower in @int4_range and upper in @int4_range do
    range
  end

  defp to_postgrex_range({lower, upper})
       when lower in @int4_range and upper in @int4_range do
    %Postgrex.Range{
      lower: if(is_nil(lower), do: :unbound, else: lower),
      upper: if(is_nil(upper), do: :unbound, else: upper),
      lower_inclusive: true,
      upper_inclusive: true
    }
  end

  defp to_postgrex_range(_), do: :error

  defp normalize_range(%Postgrex.Range{upper: upper, lower: lower} = range) do
    range
    |> normalize_upper()
    |> normalize_lower()
  end

  defp normalize_range(%Postgrex.Range{} = range), do: range

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
