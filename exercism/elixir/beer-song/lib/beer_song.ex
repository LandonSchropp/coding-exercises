# NOTE: The original problem passes a range to the `lyrics` function. I wanted to practice
# recursion, so I'm changing that to an integer.

defmodule BeerSong do

  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(0) do
    """
    No more bottles of beer on the wall, no more bottles of beer.
    Go to the store and buy some more, 99 bottles of beer on the wall.
    """
  end

  def verse(1) do
    """
    1 bottle of beer on the wall, 1 bottle of beer.
    Take it down and pass it around, no more bottles of beer on the wall.
    """
  end

  def verse(number) do
    """
    #{ bottles(number) } of beer on the wall, #{ bottles(number) } of beer.
    Take one down and pass it around, #{ bottles(number - 1) } of beer on the wall.
    """
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(integer) :: String.t()
  def lyrics(0), do: verse(0)

  def lyrics(number) do
    verse(number) <> "\n" <> lyrics(number - 1)
  end

  @doc """
  Pluralizes the word "bottles" based on the provided number.
  """
  defp bottles(1), do: "1 bottle"
  defp bottles(number), do: "#{ number } bottles"
end
