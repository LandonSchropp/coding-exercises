defmodule Operation do
  def add([ right, left | stack ]), do: [ left + right | stack ]

  def subtract([ right, left | stack ]), do: [ left - right | stack ]

  def multiply([ right, left | stack ]), do: [ left * right | stack ]

  def divide([ 0, _ | _ ]), do: raise Error.DivisionByZero
  def divide([ right, left | stack ]), do: [ div(left, right) | stack ]

  def duplicate([ top | stack ]), do: [ top, top | stack ]

  def drop([ _ | stack ]), do: stack

  def swap([ first, second | stack ]), do: [ second, first | stack ]

  def over([ first, second | stack ]), do: [ second, first, second | stack ]
end
