defmodule ExerciseTest do
  use ExUnit.Case, async: true
  doctest Exercise

  describe "when the first and second numbers are the largest" do

    test "returns the sum of the arguments" do
      assert Exercise.sum(3, 2, 1) == 13
    end
  end

  describe "when the second and third numbers are the largest" do

    test "returns the sum of the arguments" do
      assert Exercise.sum(1, 2, 3) == 13
    end
  end

  describe "when the first and third numbers are the largest" do

    test "returns the sum of the arguments" do
      assert Exercise.sum(3, 1, 2) == 13
    end
  end

  # NOTE: Normally, it's not necessary to write these kinds of tests. Elixir will yell at you if you
  # provide the wrong number of arguments to function. I'm testing this here for practice.
  # describe "when the wrong number of arguments are provided" do
  #
  #   test "raises an error" do
  #     assert_raise RuntimeError, fn ->
  #       Exercise.sum(1, 2)
  #     end
  #   end
  # end
end
