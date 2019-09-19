defmodule Direction do

  @directions [ :north, :east, :south, :west ]

  @doc """
  Rotates a direction by the given number of turns. Positive numbers represent right turns and
  negative numbers represent left turns.
  """
  def rotate(direction, turns) do
    direction
    |> direction_to_index
    |> (fn index -> index + turns end).()
    |> index_to_direction
  end

  @doc """
  Converts a direction to a vector.
  """
  def to_vector(:north), do: { 0, 1 }
  def to_vector(:east), do: { 1, 0 }
  def to_vector(:south), do: { 0, -1 }
  def to_vector(:west), do: { -1, 0 }

  # Converts a direction to its index in the directions tuple.
  defp direction_to_index(direction) do
    Enum.find_index(@directions, fn element -> element == direction end)
  end

  # Converts an index to a direction.
  defp index_to_direction(index) do
    Enum.at @directions, Integer.mod(index, length(@directions))
  end
end
