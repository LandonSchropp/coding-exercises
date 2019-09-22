defmodule BowlingTest do
  use ExUnit.Case

  defp roll_reduce(game, rolls) do
    Enum.reduce(rolls, game, fn roll, game ->
      if is_tuple(game) do
        game
      else
        Bowling.roll(game, roll)
      end
    end)
  end

  defp assert_error(value) do
    assert(
      is_tuple(value) && elem(value, 0) == :error,
      "Expected #{ inspect(value) } to be an error, but it wasn't."
    )
  end

  describe "Bowling.roll/2" do

    test "returns a list with one roll when the frame is not complete" do
      assert roll_reduce([], [ 0 ]) == [ 0 ]
      assert roll_reduce([], [ 5 ]) == [ 5 ]
    end

    test "returns one frame when the rolls contain one complete frame" do
      assert roll_reduce([], [ 0, 0 ]) == [ 0, 0 ]
      assert roll_reduce([], [ 5, 4 ]) == [ 5, 4 ]
      assert roll_reduce([], [ 6, 4 ]) == [ 6, 4 ]
      assert roll_reduce([], [ 10 ]) == [ 10 ]
    end

    test "returns multiple frames when the rolls contain more than one frame" do
      assert roll_reduce([], [ 0, 0, 0, 0, 0, 0 ]) == [ 0, 0, 0, 0, 0, 0 ]
      assert roll_reduce([], [ 5, 4, 3, 2, 1, 0 ]) == [ 5, 4, 3, 2, 1, 0 ]
      assert roll_reduce([], [ 6, 4, 7, 3, 8, 2 ]) == [ 6, 4, 7, 3, 8, 2 ]
      assert roll_reduce([], [ 10, 10, 10 ]) == [ 10, 10, 10 ]
      assert roll_reduce([], [ 10, 5, 5, 10, 5, 4, 10, 0, 0, 10, 0 ]) ==
        [ 10, 5, 5, 10, 5, 4, 10, 0, 0, 10, 0 ]
    end

    test "returns a full game of rolls when the number of rolls are valid" do
      assert Enum.slice(roll_reduce(List.duplicate(0, 18), [ 10, 5, 5 ]), -2..-1) == [ 5, 5 ]
      assert Enum.slice(roll_reduce(List.duplicate(0, 18), [ 10, 10, 10 ]), -2..-1) == [ 10, 10 ]
      assert Enum.slice(roll_reduce(List.duplicate(0, 18), [ 0, 10, 5 ]), -1..-1) == [ 5 ]
      assert Enum.slice(roll_reduce(List.duplicate(0, 18), [ 5, 5, 2 ]), -1..-1) == [ 2 ]
    end

    test "returns an error when when there are too many rolls" do
      assert_error roll_reduce(List.duplicate(0, 18), [ 10, 5, 5, 0 ])
      assert_error roll_reduce(List.duplicate(0, 18), [ 10, 10, 10, 0 ])
      assert_error roll_reduce(List.duplicate(0, 18), [ 0, 10, 5, 0 ])
      assert_error roll_reduce(List.duplicate(0, 18), [ 5, 5, 2, 0 ])
    end
  end

  test "should be able to score a game with all zeros" do
    game = Bowling.start()
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    game = roll_reduce(game, rolls)
    assert Bowling.score(game) == 0
  end

  test "should be able to score a game with no strikes or spares" do
    game = Bowling.start()
    rolls = [3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6]
    game = roll_reduce(game, rolls)
    assert Bowling.score(game) == 90
  end

  test "a spare followed by zeros is worth ten points" do
    game = Bowling.start()
    rolls = [6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    game = roll_reduce(game, rolls)
    assert Bowling.score(game) == 10
  end

  test "points scored in the roll after a spare are counted twice" do
    game = Bowling.start()
    rolls = [6, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    game = roll_reduce(game, rolls)
    assert Bowling.score(game) == 16
  end

  test "consecutive spares each get a one roll bonus" do
    game = Bowling.start()
    rolls = [5, 5, 3, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    game = roll_reduce(game, rolls)
    assert Bowling.score(game) == 31
  end

  test "a spare in the last frame gets a one roll bonus that is counted once" do
    game = Bowling.start()
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 7]
    game = roll_reduce(game, rolls)
    assert Bowling.score(game) == 17
  end

  test "a strike earns ten points in a frame with a single roll" do
    game = Bowling.start()
    rolls = [10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    game = roll_reduce(game, rolls)
    assert Bowling.score(game) == 10
  end

  test "points scored in the two rolls after a strike are counted twice as a bonus" do
    game = Bowling.start()
    rolls = [10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    game = roll_reduce(game, rolls)
    assert Bowling.score(game) == 26
  end

  test "consecutive strikes each get the two roll bonus" do
    game = Bowling.start()
    rolls = [10, 10, 10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    game = roll_reduce(game, rolls)
    assert Bowling.score(game) == 81
  end

  test "a strike in the last frame gets a two roll bonus that is counted once" do
    game = Bowling.start()
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 1]
    game = roll_reduce(game, rolls)
    assert Bowling.score(game) == 18
  end

  test "rolling a spare with the two roll bonus does not get a bonus roll" do
    game = Bowling.start()
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 3]
    game = roll_reduce(game, rolls)
    assert Bowling.score(game) == 20
  end

  test "strikes with the two roll bonus do not get bonus rolls" do
    game = Bowling.start()
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10]
    game = roll_reduce(game, rolls)
    assert Bowling.score(game) == 30
  end

  test "a strike with the one roll bonus after a spare in the last frame does not get a bonus" do
    game = Bowling.start()
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 10]
    game = roll_reduce(game, rolls)
    assert Bowling.score(game) == 20
  end

  test "all strikes is a perfect game" do
    game = Bowling.start()
    rolls = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
    game = roll_reduce(game, rolls)
    assert Bowling.score(game) == 300
  end

  test "rolls cannot score negative points" do
    game = Bowling.start()
    assert Bowling.roll(game, -1) == {:error, "Negative roll is invalid"}
  end

  test "a roll cannot score more than 10 points" do
    game = Bowling.start()
    assert Bowling.roll(game, 11) == {:error, "Pin count exceeds pins on the lane"}
  end

  test "two rolls in a frame cannot score more than 10 points" do
    game = Bowling.start()
    game = Bowling.roll(game, 5)
    assert Bowling.roll(game, 6) == {:error, "Pin count exceeds pins on the lane"}
  end

  test "bonus roll after a strike in the last frame cannot score more than 10 points" do
    game = Bowling.start()
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10]
    game = roll_reduce(game, rolls)
    assert Bowling.roll(game, 11) == {:error, "Pin count exceeds pins on the lane"}
  end

  test "two bonus rolls after a strike in the last frame cannot score more than 10 points" do
    game = Bowling.start()
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 5]
    game = roll_reduce(game, rolls)
    assert Bowling.roll(game, 6) == {:error, "Pin count exceeds pins on the lane"}
  end

  test "two bonus rolls after a strike in the last frame can score more than 10 points if one is a strike" do
    game = Bowling.start()
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 6]
    game = roll_reduce(game, rolls)
    assert Bowling.score(game) == 26
  end

  test "the second bonus rolls after a strike in the last frame cannot be a strike if the first one is not a strike" do
    game = Bowling.start()
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 6]
    game = roll_reduce(game, rolls)
    assert Bowling.roll(game, 10) == {:error, "Pin count exceeds pins on the lane"}
  end

  test "second bonus roll after a strike in the last frame cannot score more than 10 points" do
    game = Bowling.start()
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10]
    game = roll_reduce(game, rolls)
    assert Bowling.roll(game, 11) == {:error, "Pin count exceeds pins on the lane"}
  end

  test "an unstarted game cannot be scored" do
    game = Bowling.start()
    assert Bowling.score(game) == {:error, "Score cannot be taken until the end of the game"}
  end

  test "an incomplete game cannot be scored" do
    game = Bowling.start()
    rolls = [0, 0]
    game = roll_reduce(game, rolls)
    assert Bowling.score(game) == {:error, "Score cannot be taken until the end of the game"}
  end

  test "cannot roll if game already has ten frames" do
    game = Bowling.start()
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    game = roll_reduce(game, rolls)
    assert Bowling.roll(game, 0) == {:error, "Cannot roll after game is over"}
  end

  test "bonus rolls for a strike in the last frame must be rolled before score can be calculated" do
    game = Bowling.start()
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10]
    game = roll_reduce(game, rolls)
    assert Bowling.score(game) == {:error, "Score cannot be taken until the end of the game"}
  end

  test "both bonus rolls for a strike in the last frame must be rolled before score can be calculated" do
    game = Bowling.start()
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10]
    game = roll_reduce(game, rolls)
    assert Bowling.score(game) == {:error, "Score cannot be taken until the end of the game"}
  end

  test "bonus roll for a spare in the last frame must be rolled before score can be calculated" do
    game = Bowling.start()
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3]
    game = roll_reduce(game, rolls)
    assert Bowling.score(game) == {:error, "Score cannot be taken until the end of the game"}
  end
end
