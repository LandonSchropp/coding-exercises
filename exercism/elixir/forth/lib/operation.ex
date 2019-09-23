defmodule Operation do


  def add(stack) when length(stack) < 2, do: raise Error.StackUnderflow
  def add([ right, left | stack ]), do: [ left + right | stack ]

  def subtract(stack) when length(stack) < 2, do: raise Error.StackUnderflow
  def subtract([ right, left | stack ]), do: [ left - right | stack ]

  def multiply(stack) when length(stack) < 2, do: raise Error.StackUnderflow
  def multiply([ right, left | stack ]), do: [ left * right | stack ]

  def divide(stack) when length(stack) < 2, do: raise Error.StackUnderflow
  def divide([ 0, _ | _ ]), do: raise Error.DivisionByZero
  def divide([ right, left | stack ]), do: [ div(left, right) | stack ]

  def duplicate([]), do: raise Error.StackUnderflow
  def duplicate([ top | stack ]), do: [ top, top | stack ]

  def drop([]), do: raise Error.StackUnderflow
  def drop([ _ | stack ]), do: stack

  def words do
    %{
      "+" => &Operation.add/1,
      "-" => &Operation.subtract/1,
      "*" => &Operation.multiply/1,
      "/" => &Operation.divide/1,
      "dup" => &Operation.duplicate/1,
      "drop" => &Operation.drop/1
    }
  end
end
