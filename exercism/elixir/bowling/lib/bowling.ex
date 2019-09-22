defmodule Bowling do
  @negative_roll_error { :error, "Negative roll is invalid" }
  @too_many_pins_error { :error, "Pin count exceeds pins on the lane" }
  @game_over_error { :error, "Cannot roll after game is over" }
  @game_not_over_error { :error, "Score cannot be taken until the end of the game" }

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
  def roll(rolls, roll, frame \\ 0)

  # Guard against invalid rolls.
  def roll(_, roll, _) when roll < 0, do: @negative_roll_error
  def roll(_, roll, _) when roll > 10, do: @too_many_pins_error

  # Guard against too many rolls.
  def roll([ _, _, _ ], _, 9), do: @game_over_error
  def roll([ roll_1, roll_2 ], _, 9) when roll_1 + roll_2 < 10, do: @game_over_error

  # When the frame is a strike, start the next frame.
  def roll([ 10 | rolls ], roll, frame) do
    add_rolls [ 10 ], roll(rolls, roll, frame + 1)
  end

  # Guard against invalid rolls in two-roll frames.
  def roll([ frame_roll ], roll, _) when frame_roll + roll > 10, do: @too_many_pins_error

  # When there are no more rolls to recurse, the roll should be added to the end of the complete
  # rolls list.
  def roll([], roll, _), do: [ roll ]
  def roll([ last_roll ], roll, _), do: [ last_roll, roll ]

  # When the frame has two rolls (and they're valid), add both to the list.
  def roll([ roll_1, roll_2 | rolls ], roll, frame) do
    add_rolls [ roll_1, roll_2 ], roll(rolls, roll, frame + 1)
  end

  @doc """
  Returns the score of a given game of bowling if the game is complete. If the game isn't complete,
  it returns a helpful message.
  """
  @spec score(any) :: integer | String.t()
  def score(rolls, frame \\ 1)

  # Strike (last frame)
  def score([ 10, roll_2, roll_3 ], 10) do
    10 + roll_2 + roll_3
  end

  # Spare (last frame)
  def score([ roll_1, roll_2, roll_3 ], 10) when roll_1 + roll_2 == 10 do
    10 + roll_3
  end

  # Open (last frame)
  def score([ roll_1, roll_2 ], 10) when roll_1 + roll_2 < 10  do
    roll_1 + roll_2
  end

  # Strike (not last frame)
  def score([ 10, roll_2, roll_3 | rolls ], frame) when frame < 10 do
    add_scores 10 + roll_2 + roll_3, score([ roll_2, roll_3 | rolls ], frame + 1)
  end

  # Spare (not last frame)
  def score([ roll_1, roll_2, roll_3 | rolls ], frame) when (roll_1 + roll_2) == 10 and frame < 10 do
    add_scores 10 + roll_3, score([ roll_3 | rolls ], frame + 1)
  end

  # Open (not last frame)
  def score([ roll_1, roll_2 | rolls ], frame) when frame < 10 do
    add_scores roll_1 + roll_2, score(rolls, frame + 1)
  end

  # Under any other circumstances, the game is not yet over. We know the game can't have too many
  # rolls, because the `roll` method can not be called.
  def score(_, _), do: @game_not_over_error

  # This function safely adds two lists of rolls. If one of the lists is an error, this function
  # returns the error.
  defp add_rolls(_, error) when is_tuple(error), do: error
  defp add_rolls(error, _) when is_tuple(error), do: error
  defp add_rolls(rolls_1, rolls_2), do: rolls_1 ++ rolls_2

  # This function safe adds two scores together. If one of the scores is an error, this function
  # returns the error.
  defp add_scores(score_1, _) when is_tuple(score_1), do: score_1
  defp add_scores(_, score_2) when is_tuple(score_2), do: score_2
  defp add_scores(score_1, score_2), do: score_1 + score_2
end
