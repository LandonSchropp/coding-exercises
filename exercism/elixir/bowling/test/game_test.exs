defmodule GameTest do
  use ExUnit.Case

  # NOTE: The specification does not state that we need to worry about a game that's invalidly long,
  # so I'm ignoring the possibility.
  describe "over?" do

    test "returns false when the game has less than ten frames" do
      refute Game.over? List.duplicate([ 0, 0 ], 0)
      refute Game.over? List.duplicate([ 0, 0 ], 5)
      refute Game.over? List.duplicate([ 0, 0 ], 9)
    end

    test "returns true when the game has ten complete frames" do
      assert Game.over? List.duplicate([ 0, 0 ], 10)
    end

    test "returns false when the frame list ends in a spare and has ten frames" do
      refute Game.over? List.duplicate([ 0, 0 ], 9) ++ [ [ 0, 10 ] ]
    end

    test "returns true when the frame list ends in a spare and has eleven frames" do
      assert Game.over? List.duplicate([ 0, 0 ], 9) ++ [ [ 0, 10 ], [ 0 ] ]
    end

    test "returns false when the frame list ends in a strike and has ten frames" do
      refute Game.over? List.duplicate([ 0, 0 ], 9) ++ [ [ 10 ] ]
    end

    test "returns false when the frame list ends in a strike and does not have has eleven frames" do
      refute Game.over? List.duplicate([ 0, 0 ], 9) ++ [ [ 10 ], [ 0 ] ]
    end

    test "returns true when the frame list ends in a strike and has eleven complete frames" do
      assert Game.over? List.duplicate([ 0, 0 ], 9) ++ [ [ 10 ], [ 0, 0 ] ]
    end

    test "returns false when the frame list ends in two strikes and does not have twelve frames" do
      refute Game.over? List.duplicate([ 0, 0 ], 9) ++ [ [ 10 ], [ 10 ] ]
    end

    test "returns true when the frame list ends in two strikes and has twelve frames" do
      assert Game.over? List.duplicate([ 0, 0 ], 9) ++ [ [ 10 ], [ 10 ], [ 0 ] ]
    end

    test "returns true when the frame list ends in three strikes" do
      assert Game.over? List.duplicate([ 0, 0 ], 9) ++ [ [ 10 ], [ 10 ], [ 0 ] ]
    end
  end
end
