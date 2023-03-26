defmodule EctoRange.Timestamp do
  @moduledoc """
  A custom type for working with the Postgres [tsrange](https://www.postgresql.org/docs/current/rangetypes.html#RANGETYPES-BUILTIN) type.

      iex> range = {~N[2020-10-31 09:30:00], ~N[2020-11-02 10:00:00]}
      iex> cs = TestApp.Table.changeset(%TestApp.Table{name: "EctoRange.Timestamp"}, %{tsrange: range})
      iex> cs.changes
      %{tsrange: %Postgrex.Range{lower: ~N[2020-10-31 09:30:00], upper: ~N[2020-11-02 10:00:00], lower_inclusive: true, upper_inclusive: true}}

  `tsrange` in Postgres is a continuous range, and does not have any equivalent Elixir struct.

  ## Casting

  `EctoRange.Timestamp` provides a couple of conveniences when casting data. All valid
  data will be cast into a `t:Postgrex.Range.t/0` struct. When supplied to an Ecto.Changeset,
  the following types are valid

  * `{t:timestamp() | t:String.t/0, t:timestamp() | t:String.t/0}` can be used to express unbounded ranges,
  where `nil` represents an unbounded endpoint
  * `t:Postgrex.Range.t/0` will be treated as a valid range representation

  ## Loading

  All data loaded from the database will be normalized into an inclusive range
  to align with the semantics of `Date.Range.t()`
  """

  @type timestamp :: nil | NaiveDateTime.t()

  use Ecto.Type

  @impl Ecto.Type
  def type, do: :tsrange

  @impl Ecto.Type
  def cast(%Postgrex.Range{} = range) do
    {:ok, to_postgrex_range(range)}
  end

  def cast({lower, upper}) do
    with {:ok, lower} <- cast_timestamp(lower),
         {:ok, upper} <- cast_timestamp(upper) do
      {:ok, to_postgrex_range({lower, upper})}
    end
  end

  @impl Ecto.Type
  def dump(%Postgrex.Range{} = range) do
    {:ok, range}
  end

  @impl Ecto.Type
  def load(%Postgrex.Range{} = range) do
    {:ok, normalize_range(range)}
  end

  @doc """
  Converts valid `NaiveDateTime.t()` tuples into a `Postgrex.Range.t()`

      iex> EctoRange.Date.to_postgrex_range({~N[2021-03-01 08:30:00], ~N[2023-03-30 10:30:00]})
      %Postgrex.Range{lower: ~N[2021-03-01 08:30:00], upper: ~N[2023-03-30 10:30:00], lower_inclusive: true, upper_inclusive: true}
  """
  @spec to_postgrex_range(Postgrex.Range.t() | {timestamp(), timestamp()}) ::
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
  it will make the lower and upper bounds inclusive to align with the semantics
  of Date.Range.t()

      iex> range = %Postgrex.Range{lower: ~D[1989-09-22], upper: ~D[2021-03-02], lower_inclusive: true, upper_inclusive: false}
      iex> EctoRange.Date.normalize_range(range)
      %Postgrex.Range{lower: ~D[1989-09-22], upper: ~D[2021-03-01], lower_inclusive: true, upper_inclusive: true}

      iex> range = %Postgrex.Range{lower: ~D[1989-09-21], upper: ~D[2021-03-01], lower_inclusive: false, upper_inclusive: true}
      iex> EctoRange.Date.normalize_range(range)
      %Postgrex.Range{lower: ~D[1989-09-22], upper: ~D[2021-03-01], lower_inclusive: true, upper_inclusive: true}

  """
  def normalize_range(%Postgrex.Range{upper: %NaiveDateTime{}, lower: %NaiveDateTime{}} = range) do
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

  defp cast_timestamp(d) do
    case d do
      nil -> {:ok, nil}
      "" -> {:ok, nil}
      other -> Ecto.Type.cast(:naive_datetime, other)
    end
  end
end
