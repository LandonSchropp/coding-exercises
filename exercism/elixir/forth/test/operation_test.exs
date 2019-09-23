defmodule OperationTest do
  use ExUnit.Case

  describe "add/1" do

    test "raises a StackUnferflow error when the stack is too small" do
      assert_raise Error.StackUnderflow, fn -> Operation.add([]) end
      assert_raise Error.StackUnderflow, fn -> Operation.add([ 3 ]) end
    end

    test "returns the sum of the two numbers on the top of the stack" do
      assert Operation.add([ 3, 4 ]) == [ 7 ]
      assert Operation.add([ 3, 4, 5, 6, 7 ]) == [ 7, 5, 6, 7 ]
    end
  end

  describe "subtract/1" do

    test "raises a StackUnferflow error when the stack is too small" do
      assert_raise Error.StackUnderflow, fn -> Operation.subtract([]) end
      assert_raise Error.StackUnderflow, fn -> Operation.subtract([ 3 ]) end
    end

    test "returns the sum of the two numbers on the top of the stack" do
      assert Operation.subtract([ 3, 4 ]) == [ 1 ]
      assert Operation.subtract([ 3, 4, 5, 6, 7 ]) == [ 1, 5, 6, 7 ]
    end
  end

  describe "multiply/1" do

    test "raises a StackUnferflow error when the stack is too small" do
      assert_raise Error.StackUnderflow, fn -> Operation.multiply([]) end
      assert_raise Error.StackUnderflow, fn -> Operation.multiply([ 3 ]) end
    end

    test "returns the sum of the two numbers on the top of the stack" do
      assert Operation.multiply([ 3, 4 ]) == [ 12 ]
      assert Operation.multiply([ 3, 4, 5, 6, 7 ]) == [ 12, 5, 6, 7 ]
    end
  end

  describe "divide/1" do

    test "raises a StackUnferflow error when the stack is too small" do
      assert_raise Error.StackUnderflow, fn -> Operation.divide([]) end
      assert_raise Error.StackUnderflow, fn -> Operation.divide([ 3 ]) end
    end

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

    test "raises a StackUnferflow error when the stack is too small" do
      assert_raise Error.StackUnderflow, fn -> Operation.duplicate([]) end
    end

    test "returns the duplicate of the top value on the top of the stack" do
      assert Operation.duplicate([ 3 ]) == [ 3, 3 ]
      assert Operation.duplicate([ 3, 4, 5, 6, 7 ]) == [ 3, 3, 4, 5, 6, 7 ]
    end
  end
end
