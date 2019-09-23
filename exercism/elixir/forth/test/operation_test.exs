defmodule OperationTest do
  use ExUnit.Case

  describe "add/1" do

    test "returns the sum of the two numbers on the top of the stack" do
      assert Operation.add([ 3, 4 ]) == [ 7 ]
      assert Operation.add([ 3, 4, 5, 6, 7 ]) == [ 7, 5, 6, 7 ]
    end
  end

  describe "subtract/1" do

    test "returns the sum of the two numbers on the top of the stack" do
      assert Operation.subtract([ 3, 4 ]) == [ 1 ]
      assert Operation.subtract([ 3, 4, 5, 6, 7 ]) == [ 1, 5, 6, 7 ]
    end
  end

  describe "multiply/1" do

    test "returns the sum of the two numbers on the top of the stack" do
      assert Operation.multiply([ 3, 4 ]) == [ 12 ]
      assert Operation.multiply([ 3, 4, 5, 6, 7 ]) == [ 12, 5, 6, 7 ]
    end
  end

  describe "divide/1" do

    test "raises a DivisionByZero error when the divisor is 0" do
      assert_raise Error.DivisionByZero, fn -> Operation.divide([ 0, 1 ]) end
    end

    test "returns the value using integer division" do
      assert Operation.divide([ 3, 4 ]) == [ 1 ]
    end

    test "returns the sum of the two numbers on the top of the stack" do
      assert Operation.divide([ 3, 4 ]) == [ 1 ]
      assert Operation.divide([ 3, 4, 5, 6, 7 ]) == [ 1, 5, 6, 7 ]
    end
  end

  describe "duplicate/1" do

    test "returns the duplicate of the top value on the top of the stack" do
      assert Operation.duplicate([ 3 ]) == [ 3, 3 ]
      assert Operation.duplicate([ 3, 4, 5, 6, 7 ]) == [ 3, 3, 4, 5, 6, 7 ]
    end
  end

  describe "drop/1" do

    test "removes the top value from the stack" do
      assert Operation.drop([ 3 ]) == []
      assert Operation.drop([ 3, 4, 5, 6, 7 ]) == [ 4, 5, 6, 7 ]
    end
  end

  describe "swap/1" do

    test "swaps the top two elements on the stack" do
      assert Operation.swap([ 3, 4 ]) == [ 4, 3 ]
      assert Operation.swap([ 3, 4, 5, 6, 7 ]) == [ 4, 3, 5, 6, 7 ]
    end
  end

  describe "over/1" do

    test "over the top two elements on the stack" do
      assert Operation.over([ 3, 4 ]) == [ 4, 3, 4 ]
      assert Operation.over([ 3, 4, 5, 6, 7 ]) == [ 4, 3, 4, 5, 6, 7 ]
    end
  end
end
