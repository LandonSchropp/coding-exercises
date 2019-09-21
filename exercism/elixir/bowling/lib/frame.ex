defmodule Frame do

  @doc """
  Returns whether the frame is complete.
  """
  def complete?([ 10 ]), do: true
  def complete?([ _, _ ]), do: true
  def complete?(_), do: false

  @doc """
  Given an list of rolls, this function chunks the list into rolls. For recursive simplicity, it
  treats the extra rolls in the last frame as new frames.
  """
  def chunk(rolls)
  def chunk([]), do: []
  def chunk([ head ]), do: [ [ head ] ]
  def chunk([ 10 | tail ]), do: [ [ 10 ] | chunk(tail) ]
  def chunk([ first | [ second | tail ] ]), do: [ [ first, second ] | chunk(tail) ]

  def strike?([ 10 ]), do: true
  def strike?(_), do: false

  def spare?([]), do: false
  def spare?([ _ ]), do: false
  def spare?([ first_roll, second_roll ]), do: first_roll + second_roll == 10
end
