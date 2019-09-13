# Questions for Jon:
#
# * Is there a way to write a module function capture that automatically pulls an element out of
#   tuple? Integer.parse/1 returns a tuple, which is really annoying when piping.
# * How can I rewrite the first item in `convert_digit_to_roman_numeral` as a pipe? I can't seem to
#   figure out the pipe syntax.
# * How can I write the anonymous function in `convert_digit_to_roman_numeral` as a capture?
defmodule RomanNumerals do

  # Defines the numbers used.
  @numerals { "I", "V", "X", "L", "C", "D", "M" }

  # Defines the pattern for each digit, starting with 0.
  @numeral_patterns {
    [],
    [ 0 ],
    [ 0, 0 ],
    [ 0, 0, 0 ],
    [ 0, 1 ],
    [ 1 ],
    [ 1, 0 ],
    [ 1, 0, 0 ],
    [ 1, 0, 0, 0 ],
    [ 0, 2 ]
  }

  @doc """
  Convert the number to a Roman numeral.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    number

    # Convert the number to a decimal string and map each digit to an integer.
    |> Integer.to_string
    |> String.split("", trim: true)
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(&elem(&1, 0))

    # Convert the number to a list of tuples, with the first element being the digit and the second
    # representing the digit's power of 10 (10^n). This *could* be done by doing some math with the
    # list length, but it's easier to just reverse twice to get the correct index.
    |> Enum.reverse
    |> Enum.with_index
    |> Enum.reverse

    # Map each digit and power to a Roman numeral.
    |> Enum.map(fn ({ digit, power }) -> convert_digit_to_roman_numeral(digit, power) end)

    # Flatten and join the numerals into a single string.
    |> List.flatten
    |> Enum.join("")
  end

  @doc """
  Converts a digit and power of 10 into a Roman numeral.
  """
  def convert_digit_to_roman_numeral(digit, power) do
    elem(@numeral_patterns, digit)
    |> Enum.map(fn offset -> elem(@numerals, offset + power * 2) end)
  end
end
