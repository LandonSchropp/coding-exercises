defmodule FrameTest do
  use ExUnit.Case

  describe "chunk" do

    test "returns an empty list when the rolls list is empty" do
      assert Frame.chunk([]) == []
    end

    test "returns only one frame when the frame is not complete" do
      assert Frame.chunk([ 0 ]) == [ [ 0 ] ]
      assert Frame.chunk([ 5 ]) == [ [ 5 ] ]
    end

    test "returns one frame when the rolls contain one complete frame" do
      assert Frame.chunk([ 0, 0 ]) == [ [ 0, 0 ] ]
      assert Frame.chunk([ 5, 4 ]) == [ [ 5, 4 ] ]
      assert Frame.chunk([ 6, 4 ]) == [ [ 6, 4 ] ]
      assert Frame.chunk([ 10 ]) == [ [ 10 ] ]
    end

    test "returns one frame when the rolls contain more than one frame" do
      assert Frame.chunk([ 0, 0, 0, 0, 0, 0 ]) == [ [ 0, 0 ], [ 0, 0 ], [ 0, 0 ] ]
      assert Frame.chunk([ 5, 4, 3, 2, 1, 0 ]) == [ [ 5, 4 ], [ 3, 2 ], [ 1, 0 ] ]
      assert Frame.chunk([ 6, 4, 7, 3, 8, 2 ]) == [ [ 6, 4 ], [ 7, 3 ], [ 8, 2 ] ]
      assert Frame.chunk([ 10, 10, 10 ]) == [ [ 10 ], [ 10 ], [ 10 ] ]

      assert Frame.chunk([ 10, 5, 5, 10, 5, 4, 10, 0, 0, 10, 0 ]) == [
        [ 10 ],
        [ 5, 5 ],
        [ 10 ],
        [ 5, 4 ],
        [ 10 ],
        [ 0, 0 ],
        [ 10 ],
        [ 0 ]
      ]
    end
  end

  describe "strike?" do

    test "returns false when the frame is empty" do
      refute Frame.strike?([])
    end

    test "returns true when the frame contains only one roll of ten" do
      assert Frame.strike?([ 10 ])
    end

    test "returns false when the frame contains one value that's not 10" do
      refute Frame.strike?([ 9 ])
      refute Frame.strike?([ 0 ])
    end

    test "returns false when the frame contains two values" do
      refute Frame.strike?([ 0, 10 ])
      refute Frame.strike?([ 9, 1 ])
    end
  end

  describe "spare?" do

    test "returns false when the frame is empty" do
      refute Frame.spare?([])
    end

    test "returns false when the frame only contains one value" do
      refute Frame.spare?([ 0 ])
      refute Frame.spare?([ 10 ])
    end

    test "returns false when the frame does not add up to 10" do
      refute Frame.spare?([ 0, 0 ])
      refute Frame.spare?([ 1, 8 ])
      refute Frame.spare?([ 8, 1 ])
    end

    test "returns true when the frame adds up to 10" do
      assert Frame.spare?([ 0, 10 ])
      assert Frame.spare?([ 9, 1 ])
      assert Frame.spare?([ 5, 5 ])
    end
  end

  describe "open?" do

    test "returns false when the frame is empty" do
      refute Frame.open?([])
    end

    test "returns false when the frame only contains one value" do
      refute Frame.open?([ 0 ])
      refute Frame.open?([ 5 ])
      refute Frame.open?([ 10 ])
    end

    test "returns false when the frame is a spare" do
      refute Frame.open?([ 0, 10 ])
      refute Frame.open?([ 5, 5 ])
    end

    test "returns true when the frame contains two values and is not a spare" do
      assert Frame.open?([ 0, 9 ])
      assert Frame.open?([ 5, 4 ])
      assert Frame.open?([ 8, 1 ])
    end
  end
end
