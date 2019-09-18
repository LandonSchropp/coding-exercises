defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map

  # Sanitization: Split the string into a list of words and pipe it into the recursive count.
  def count(sentence) when is_binary(sentence) do
    sentence |> String.downcase |> String.split(~r/[^[:alpha:]\d-]+/u, trim: true) |> count
  end

  # Base case: The list is empty.
  def count([]), do: %{}

  # Recursive case: Update the current value of the item by 1, or set it to 1 if not yet present.
  def count([ head | tail ]), do: Map.update(count(tail), head, 1, fn value -> value + 1 end)
end
