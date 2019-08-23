ExUnit.start

defmodule ExerciseTest do
  use ExUnit.Case, async: true

  describe "when the arguments are valid" do

    test "returns the sum of the arguments" do
      assert Exercise.sum(1, 2, 3) == 6
    end
  end

  # NOTE: Normally, it's not necessary to write these kinds of tests. Elixir will yell at you if you
  # provide bad arguments to functions. I'm testing this here for practice.
  describe "when the wrong number of arguments are provided" do

    test "raises an error" do
      assert_raise RuntimeError, fn ->
        Exercise.sum(1, 2)
      end
    end
  end
end
