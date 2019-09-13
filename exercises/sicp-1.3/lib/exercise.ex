defmodule Exercise do
  @moduledoc """
  Documentation for Exercise.
  """

  @doc """
  Sums the squares of the two largest numbers of provided arguments.
  """
  def sum(a, b, c) do
    [ first, second ] = Enum.take(Enum.sort([ a, b, c ]), -2)
    first * first + second * second
  end
end
