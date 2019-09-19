defmodule RobotSimulatorTest do
  use ExUnit.Case

  describe "Direction.rotate/3" do

    test "it does not rotate the direction" do
      assert Direction.rotate(:north, 0) == :north
    end

    test "rotating the direction to the right once" do
      assert Direction.rotate(:north, 1) == :east
      assert Direction.rotate(:east, 1) == :south
      assert Direction.rotate(:south, 1) == :west
      assert Direction.rotate(:west, 1) == :north
    end

    test "rotating the direction to the left once" do
      assert Direction.rotate(:north, -1) == :west
      assert Direction.rotate(:west, -1) == :south
      assert Direction.rotate(:south, -1) == :east
      assert Direction.rotate(:east, -1) == :north
    end

    test "rotating the direction to the right multiple times" do
      assert Direction.rotate(:north, 2) == :south
      assert Direction.rotate(:north, 3) == :west
      assert Direction.rotate(:north, 4) == :north
    end

    test "rotating the direction to the left multiple times" do
      assert Direction.rotate(:north, -2) == :south
      assert Direction.rotate(:north, -3) == :east
      assert Direction.rotate(:north, -4) == :north
    end
  end
end
