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
end
