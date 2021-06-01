defmodule ExRush.Types.MaybeFloat do
  @moduledoc """
  Represents type of float number, which can be defined as a string or integer.
  """

  use Ecto.Type

  def type, do: :float

  def cast(string) when is_binary(string), do: {:ok, safe_parse_float(string)}
  def cast(integer) when is_integer(integer), do: {:ok, integer / 1}
  def cast(float) when is_float(float), do: {:ok, float}
  def cast(_), do: :error

  def load(value), do: {:ok, value}
  def dump(value), do: {:ok, value}

  defp safe_parse_float(string) do
    case Integer.parse(string) do
      {number, ""} ->
        number / 1

      _ ->
        String.to_float(string)
    end
  end
end
