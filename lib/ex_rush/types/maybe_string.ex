defmodule ExRush.Types.MaybeString do
  @moduledoc """
  Represents type of string, which can be defined as number.
  """

  use Ecto.Type

  def type, do: :float

  def cast(string) when is_binary(string), do: {:ok, string}
  def cast(integer) when is_integer(integer), do: {:ok, Integer.to_string(integer)}
  def cast(float) when is_float(float), do: {:ok, Float.to_string(float)}
  def cast(_), do: :error

  def load(value), do: {:ok, value}
  def dump(value), do: {:ok, value}
end
