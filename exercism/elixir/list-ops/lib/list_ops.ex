defmodule ListOps do

  @spec count(list) :: non_neg_integer
  def count([]), do: 0
  def count([ _ | tail ]), do: 1 + count(tail)

  @spec reverse(list) :: list
  def reverse(list, accumulator \\ [])
  def reverse([], accumulator), do: accumulator
  def reverse([ head | tail ], accumulator), do: reverse(tail, [ head | accumulator ])

  @spec map(list, (any -> any)) :: list
  def map([], _), do: []
  def map([ head | tail ], iteratee), do: [ iteratee.(head) | map(tail, iteratee) ]

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _), do: []

  def filter([ head | tail ], iteratee) do
    accumulator = filter(tail, iteratee)
    if iteratee.(head), do: [ head | accumulator ], else: accumulator
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], accumulator, _), do: accumulator

  def reduce([ head | tail ], accumulator, iteratee) do
    reduce(tail, iteratee.(head, accumulator), iteratee)
  end

  @spec append(list, list) :: list
  def append([], accumulator), do: accumulator
  def append([ head | tail ], accumulator), do: [ head | append(tail, accumulator) ]

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat([ head | tail ]), do: append(head, concat(tail))
end
