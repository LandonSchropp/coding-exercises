defmodule Bowling do

  @doc """
  Creates a new game of bowling that can be used to store the results of the game.
  """
  @spec start() :: any
  def start, do: []

  @doc """
  Records the number of pins knocked down on a single roll. Returns `any` unless there is something
  wrong with the given number of pins, in which case it returns a helpful message.
  """
  @spec roll(any, integer) :: any | String.t()
  def roll(rolls, roll, frame_in_progress? \\ false)
  def roll(_, roll, _) when roll < 0, do: {:error, "Negative roll is invalid"}
  def roll(_, roll, _) when roll > 10, do: {:error, "Pin count exceeds pins on the lane"}

  # When there are no more rolls to recurse, the roll should be added to the end of the list.
  def roll([], roll, _), do: [ roll ]

  # When the pins for an in-progress roll add up to more than ten pins.
  def roll([ last_roll ], roll, true) when last_roll + roll > 10 do
    {:error, "Pin count exceeds pins on the lane"}
  end

  # When the roll is a strike, the next frame should not be in progress.
  def roll([ last_roll | rolls ], 10, false) do
    add_last_roll last_roll, roll(rolls, 10, false)
  end

  # When the frame contains two rolls, then the in progress status should flip.
  def roll([ last_roll | rolls ], roll, in_progress) do
    add_last_roll last_roll, roll(rolls, roll, !in_progress)
  end

  # Safely adds a roll to the rolls list, returning errors if needed.
  defp add_last_roll(last_roll, rolls_or_error)
  defp add_last_roll(_, error) when is_map(error), do: error
  defp add_last_roll(roll, rolls), do: [ roll | rolls ]

  @doc """
  Returns the score of a given game of bowling if the game is complete. If the game isn't complete,
  it returns a helpful message.
  """
  @spec score(any) :: integer | String.t()
  def score(rolls, frame \\ 0)

  # If there are no more rolls, but we haven't finished ten complete frames, then the game is not
  # complete.

  # When we've finished 10 complete frames, the game is over.
  def score(_, 10), do: 0

  # Strike
  def score([ 10, roll_2, roll_3 | rolls ], frame) do
    10 + roll_2 + roll_3 + score([ roll_2, roll_3 | rolls ], frame + 1)
  end

  # Spare
  def score([ roll_1, roll_2, roll_3 | rolls ], frame) when (roll_1 + roll_2) == 10 do
    10 + roll_3 + score([ roll_3 | rolls ], frame + 1)
  end

  # Open
  def score([ roll_1, roll_2 | rolls ], frame) do
    roll_1 + roll_2 + score(rolls, frame + 1)
  end
end
