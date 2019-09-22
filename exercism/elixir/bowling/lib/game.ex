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
  def over?([ ten ], 9), do: !strike?(ten) && !spare?(ten)

  # Everything else.
  def over?([], _), do: false

  # Recursive case
  def over?([ _ | tail ], count), do: over?(tail, count + 1)

  @doc """
  Returns the current score of the game.
  """
  def score(rolls, score \\ 0, bonuses \\ [])

  # Base case: Game is over.
  def score([], score, _), do: score

  # Recursive case: Add the value of the frame to the current score and recurse, updating the active
  # strike and spare counts accordingly.
  def score([ frame | tail ], score, bonuses) do
    first_roll = Enum.at(frame, 0)
    second_roll = Enum.at(frame, 1) || 0

    IO.inspect(first_roll, label: "\nFirst roll")
    IO.inspect(first_roll, label: "Second roll")
    IO.inspect(bonuses, label: "Bonuses")

    # NOTE: The spares are not included in the second roll because it shouldn't be possible to have
    # more than one active spare at a time.
    updated_score = score +
      first_roll * (1 + length(bonuses)) +
      second_roll * (1 + length(decrement_bonuses(bonuses, 1)))

    # Update the bonuses
    if strike? frame do
      score(tail, updated_score, [ 2 | decrement_bonuses(bonuses, 1) ])
    else
      if spare? frame do
        score(tail, updated_score, [ 1 | decrement_bonuses(bonuses, 2) ])
      else
        score(tail, updated_score, decrement_bonuses(bonuses, 2))
      end
    end
  end

  # Given a list of bonuses, this function decrements them. It also removes bonuses that hit 0 from
  # the list.
  defp decrement_bonuses(bonuses, amount) do
    bonuses
    |> Enum.map(fn bonus -> bonus - amount end)
    |> Enum.filter(fn bonus -> bonus > 0 end)
  end
end
