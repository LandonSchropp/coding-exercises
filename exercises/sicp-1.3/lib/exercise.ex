defmodule Exercise do
  @moduledoc """
  Documentation for Exercise.
  """

  @doc """
  Sums three numbers together.

  ## Examples

      Exercise.

  """
  def sum(a, b, c) do
    [ first, second ] = Enum.take(Enum.sort([ a, b, c ]), -2)
    first * first + second * second
  end
end
