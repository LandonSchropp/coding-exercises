defmodule Game do
  import Frame

  @doc """
  Returns true when a game is over.

  NOTE: The specification does not state that we need to worry about a game that's invalidly long,
  so I'm ignoring the possibility.
  """
  def over?(frames, count \\ 0)

  # Twelve frames
  def over?([ ten, eleven, _ ], 9), do: strike?(ten) && strike?(eleven)

  # Eleven frames
  def over?([ ten, eleven ], 9), do: strike?(ten) && (spare?(eleven) || open?(eleven)) || spare?(ten)

  # Ten frames
  def over?([ ten ], 9), do: !Frame.strike?(ten) && !Frame.spare?(ten)

  # Everything else.
  def over?([], _), do: false

  # Recursive case
  def over?([ _ | tail ], count), do: over?(tail, count + 1)
end
