defmodule Frame do

  @doc """
  Given an list of rolls, this function chunks the list into rolls. For recursive simplicity, it
  treats the extra rolls in the last frame as new frames.
  """
  def chunk(rolls)
  def chunk([]), do: []
  def chunk([ head ]), do: [ [ head ] ]
  def chunk([ 10 | tail ]), do: [ [ 10 ] | chunk(tail) ]
  def chunk([ first | [ second | tail ] ]), do: [ [ first, second ] | chunk(tail) ]

  @doc """
  Returns true if all pins were knocked down on the first roll.
  """
  def strike?([ 10 ]), do: true
  def strike?(_), do: false

  @doc """
  Returns true if all pins were knocked down by the second roll.
  """
  def spare?([ first_roll, second_roll ]), do: first_roll + second_roll == 10
  def spare?(_), do: false

  @doc """
  Returns true if the frame is complete but is not a strike or spare.
  """
  def open?([ first_roll, second_roll ]), do: first_roll + second_roll != 10
  def open?(_), do: false
end
