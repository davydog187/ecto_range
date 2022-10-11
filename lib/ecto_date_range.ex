defmodule Ecto.DateRange do
  @moduledoc """
  A custom type for working with the Postgres [daterange](https://www.postgresql.org/docs/current/rangetypes.html#RANGETYPES-BUILTIN) type.
  """

  use Ecto.Type

  defstruct [:range, :lower_inclusive, :upper_inclusive]

  @type t :: %__MODULE__{
          range: DateRange.t(),
          lower_inclusive: boolean(),
          upper_inclusive: boolean()
        }

  def type, do: :daterange

  def cast(term) do
    dbg()
    :error
  end

  def dump(%Date.Range{} = range) do
    dbg()

    {:ok,
     %Postgrex.Range{
       upper: range.last,
       lower: range.first,
       upper_inclusive: false,
       lower_inclusive: true
     }}
  end

  def embed_as(term) do
    dbg()
    :error
  end

  def equal?(one, two) do
    dbg()
    :error
  end

  def load(%Postgrex.Range{lower: lower, upper: upper}) do
    dbg()

    with {:ok, lower} <- Ecto.Type.load(:date, lower),
         {:ok, upper} <- Ecto.Type.load(:date, upper) do
      {:ok, Date.range(lower, upper)}
    end
  end
end
