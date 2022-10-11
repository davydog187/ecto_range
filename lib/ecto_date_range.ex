defmodule Ecto.DateRange do
  @moduledoc """
  A custom type for working with the Postgres [daterange](https://www.postgresql.org/docs/current/rangetypes.html#RANGETYPES-BUILTIN) type.
  """

  use Ecto.Type

  defstruct [:range, :lower_inclusive, :upper_inclusive]

  @type t :: %__MODULE__{
          range: Date.Range.t(),
          lower_inclusive: boolean(),
          upper_inclusive: boolean()
        }

  @impl Ecto.Type
  def type, do: :daterange

  @impl Ecto.Type
  def cast(term) do
    dbg()
    :error
  end

  @impl Ecto.Type
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

  @impl Ecto.Type
  def equal?(one, two) do
    dbg()
    true
  end

  @impl Ecto.Type
  def load(%Postgrex.Range{lower: lower, upper: upper}) do
    dbg()

    with {:ok, lower} <- Ecto.Type.load(:date, lower),
         {:ok, upper} <- Ecto.Type.load(:date, upper) do
      {:ok, Date.range(lower, upper)}
    end
  end
end
