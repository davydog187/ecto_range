defmodule Ecto.DateRange do
  @moduledoc """
  A custom type for working with the Postgres [daterange](https://www.postgresql.org/docs/current/rangetypes.html#RANGETYPES-BUILTIN) type.

      iex> range = Date.range(~D[1989-09-22], ~D[2021-03-01])
      iex> cs = TestApp.Table.changeset(%TestApp.Table{name: "Ecto.DateRange"}, %{range: range})
      iex> cs.changes
      %{range: %Postgrex.Range{lower: ~D[1989-09-22], upper: ~D[2021-03-01], lower_inclusive: true, upper_inclusive: true}}


  ## Casting

  `Ecto.DateRange` provides a couple of conveniences when casting data. All valid
  data will be cast into a `%Postgrex.Range{}` struct. When supplied to an Ecto.Changeset,
  the following types are valid

  * `Date.Range.t()` will be treated as an inclusive range
  * `{Date.t() | nil, Date.t() | nil}` can be used to express unbounded ranges,
  where `nil` represents an unbounded endpoint
  * `Postgrex.Range.t()` will be treated as a valid range representation

  ## Loading

  All data loaded from the database will be normalized into an inclusive range
  to align with the semantics of `Date.Range.t()`
  """

  use Ecto.Type

  @impl Ecto.Type
  def type, do: :daterange

  @impl Ecto.Type
  def cast(%Date.Range{} = range) do
    {:ok, to_postgrex_range(range)}
  end

  def cast({lower, upper} = range) do
    if valid_date?(lower) and valid_date?(upper) do
      {:ok, to_postgrex_range(range)}
    else
      :error
    end
  end

  @impl Ecto.Type
  def dump(%Date.Range{} = range) do
    {:ok, to_postgrex_range(range)}
  end

  def dump(%Postgrex.Range{} = range) do
    {:ok, range}
  end

  @impl Ecto.Type
  def load(%Postgrex.Range{} = range) do
    {:ok, normalize_range(range)}
  end

  @doc """
  Converts valid `Date.Range.t()` or `Date.t()` tuples into a `Postgrex.Range.t()`

      iex> Ecto.DateRange.to_postgrex_range(Date.range(~D[1989-09-22], ~D[2021-03-01]))
      %Postgrex.Range{lower: ~D[1989-09-22], upper: ~D[2021-03-01], lower_inclusive: true, upper_inclusive: true}
  """
  @spec to_postgrex_range(Date.Range.t() | Postgrex.Range.t() | {Date.t() | nil, Date.t() | nil}) ::
          Postgrex.Range.t()
  def to_postgrex_range(%Postgrex.Range{} = range), do: range

  def to_postgrex_range(%Date.Range{first: first, last: last}) do
    %Postgrex.Range{
      lower: first,
      lower_inclusive: true,
      upper: last,
      upper_inclusive: true
    }
  end

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
  it will make the lower and upper bounds inclusive to align with the semantics
  of Date.Range.t()

      iex> range = %Postgrex.Range{lower: ~D[1989-09-22], upper: ~D[2021-03-02], lower_inclusive: true, upper_inclusive: false}
      iex> Ecto.DateRange.normalize_range(range)
      %Postgrex.Range{lower: ~D[1989-09-22], upper: ~D[2021-03-01], lower_inclusive: true, upper_inclusive: true}

      iex> range = %Postgrex.Range{lower: ~D[1989-09-21], upper: ~D[2021-03-01], lower_inclusive: false, upper_inclusive: true}
      iex> Ecto.DateRange.normalize_range(range)
      %Postgrex.Range{lower: ~D[1989-09-22], upper: ~D[2021-03-01], lower_inclusive: true, upper_inclusive: true}

  """
  def normalize_range(%Postgrex.Range{upper: %Date{}, lower: %Date{}} = range) do
    range
    |> normalize_upper()
    |> normalize_lower()
  end

  def normalize_range(%Postgrex.Range{} = range), do: range

  defp normalize_upper(%Postgrex.Range{} = range) do
    if range.upper_inclusive do
      range
    else
      %{range | upper_inclusive: true, upper: Date.add(range.upper, -1)}
    end
  end

  defp normalize_lower(%Postgrex.Range{} = range) do
    if range.lower_inclusive do
      range
    else
      %{range | lower_inclusive: true, lower: Date.add(range.lower, 1)}
    end
  end

  defp valid_date?(nil), do: true
  defp valid_date?(%Date{}), do: true
  defp valid_date?(_), do: false
end
