defmodule GameTest do
  use ExUnit.Case
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

  describe "score" do

    # test "returns 0 when the frames list is empty" do
    #   assert Game.score([]) == 0
    # end
    #
    # test "returns 0 when the game is all gutter balls" do
    #   assert Game.score(List.duplicate([ 0, 0 ], 10)) == 0
    # end
    #
    # test "returns the sum of the scores when the game does not contain strikes or spares" do
    #   assert Game.score(List.duplicate([ 5, 4 ], 10)) == 90
    # end
    #
    # test "returns the sum of the scores when the game is in progress" do
    #   assert Game.score(List.duplicate([ 5, 4 ], 5) ++ [ [ 5 ] ]) == 50
    # end
    #
    # test "includes the next frame's scores when the game contains spares" do
    #   assert Game.score([
    #     [ 0, 0 ],
    #     [ 0, 10 ],
    #     [ 0, 0 ],
    #     [ 0, 10 ],
    #     [ 5, 5 ],
    #     [ 3, 0 ],
    #     [ 0, 0 ],
    #     [ 0, 0 ],
    #     [ 0, 0 ],
    #     [ 0, 0 ]
    #   ]) == 41
    # end
    #
    # test "includes the the two frame's scores when the game contains strikes" do
    #   assert Game.score([
    #     [ 0, 0 ],
    #     [ 10 ], # 10
    #     [ 0, 0 ],
    #     [ 10 ], # 30
    #     [ 5, 5 ], # 43
    #     [ 3, 0 ], # 46
    #     [ 10 ], # 69
    #     [ 10 ], # 85
    #     [ 3, 3 ], # 91
    #     [ 0, 0 ]
    #   ]) == 91
    # end
    #
    # test "includes the extra roll when the game's tenth frame contains a spare" do
    #   assert Game.score(List.duplicate([ 0, 0 ], 9) ++ [ [ 0, 10 ], [ 5 ] ]) == 20
    # end
    #
    # test "includes the extra two rolls when the tenth frame contains a strike" do
    #
    # end

    test "returns 300 for a perfect game" do
      assert Game.score(List.duplicate([ 10 ], 12)) == 300
    end

    # test "returns the correct value for an example game from Wikipedia" do
    #
    # end
  end
end
