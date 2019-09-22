defmodule Bowling do
  @negative_roll_error { :error, "Negative roll is invalid" }
  @too_many_pins_error { :error, "Pin count exceeds pins on the lane" }
  @game_over_error { :error, "Cannot roll after game is over" }

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
  def roll(rolls, roll, frame \\ 0, complete_rolls \\ [])

  # Guard against invalid rolls.
  def roll(_, roll, _, _) when roll < 0, do: @negative_roll_error
  def roll(_, roll, _, _) when roll > 10, do: @too_many_pins_error

  # Guard against too many rolls.
  def roll([ _, _, _ ], _, 9, _), do: @game_over_error
  def roll([ roll_1, roll_2 ], _, 9, _) when roll_1 + roll_2 < 10, do: @game_over_error

  # When the frame is a strike, start the next frame.
  def roll([ 10 | rolls ], roll, frame, complete_rolls) do
    roll(rolls, roll, frame + 1, complete_rolls ++ [ 10 ])
  end

  # Guard against invalid rolls in two-roll frames.
  def roll([ frame_roll ], roll, _, _) when frame_roll + roll > 10, do: @too_many_pins_error

  # When there are no more rolls to recurse, the roll should be added to the end of the complete
  # rolls list.
  def roll([], roll, _, complete_rolls), do: complete_rolls ++ [ roll ]
  def roll([ last_roll ], roll, _, complete_rolls), do: complete_rolls ++ [ last_roll, roll ]

  # When the frame has two rolls (and they're valid), add both to the list.
  def roll([ roll_1, roll_2 | rolls ], roll, frame, complete_rolls) do
    roll(rolls, roll, frame + 1, complete_rolls ++ [ roll_1, roll_2 ])
  end

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
