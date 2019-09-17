defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count([]), do: 0
  def count([ _ | tail ]), do: 1 + count(tail)

  # Recurses the list and reverses it by passing the resulted reversed list as a parameter.
  @spec reverse(list) :: list
  def reverse(list), do: reverse(list, [])
  defp reverse([], reversed_list), do: reversed_list
  defp reverse([ head | tail ], reversed_list), do: reverse(tail, [ head | reversed_list ])

  @spec map(list, (any -> any)) :: list
  def map([], _), do: []
  def map([ head | tail ], iteratee), do: [ iteratee.(head) | map(tail, iteratee) ]

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _), do: []

  def filter([ head | tail ], iteratee) do
    (if iteratee.(head), do: [ head ], else: []) ++ filter(tail, iteratee)
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], accumulator, iteratee), do: accumulator

  def reduce([ head | tail ], accumulator, iteratee) do
    reduce(tail, iteratee.(head, accumulator), iteratee)
  end

  @spec append(list, list) :: list
  def append([], all), do: all
  def append([ head | tail ], all), do: [ head | append(tail, all) ]

  @spec concat([[any]]) :: [any]
  def concat(ll) do
  end
end
