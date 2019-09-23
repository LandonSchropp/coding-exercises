defmodule Operation do

  @operations %{
    "+" => &Operation.add/1,
    "-" => &Operation.subtract/1,
    "*" => &Operation.multiply/1,
    "/" => &Operation.divide/1,
  }

  def add(stack) when length(stack) < 2, do: raise Error.StackUnderflow
  def add([ right, left | stack ]), do: [ left + right | stack ]

  def subtract(stack) when length(stack) < 2, do: raise Error.StackUnderflow
  def subtract([ right, left | stack ]), do: [ left - right | stack ]

  def multiply(stack) when length(stack) < 2, do: raise Error.StackUnderflow
  def multiply([ right, left | stack ]), do: [ left * right | stack ]

  def divide(stack) when length(stack) < 2, do: raise Error.StackUnderflow
  def divide([ 0, _ | _ ]), do: raise Error.DivisionByZero
  def divide([ right, left | stack ]), do: [ div(left, right) | stack ]
end
