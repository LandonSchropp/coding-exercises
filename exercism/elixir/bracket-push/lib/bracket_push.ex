defmodule BracketPush do

  @brackets %{
    "{" => "}",
    "[" => "]",
    "(" => ")"
  }

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly.
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(string) do
    string
    |> String.replace(~r/[^\[\](){}]/, "")
    |> String.codepoints
    |> check_brackets([])
  end

  # Recursive case
  defp check_brackets(characters, stack) do

    if Enum.empty?(characters) do
      Enum.empty? stack
    else
      [ head | characters ] = characters

      cond do
        opening_bracket? head ->
          check_brackets(characters, [ head | stack ])
        Enum.empty?(stack) ->
          false
        true ->
          [ opening_bracket | stack ] = stack
          head == Map.fetch!(@brackets, opening_bracket) && check_brackets(characters, stack)
      end
    end
  end

  @doc """
  Returns true if the character is an opening bracket and false if it isn't.
  """
  @spec opening_bracket?(String.t()) :: boolean
  def opening_bracket?(character) do
    Enum.member? Map.keys(@brackets), character
  end

  @doc """
  Returns true if opening_character matches closing_character.
  """
  @spec brackets_match?(String.t(), String.t()) :: boolean
  def brackets_match?(opening_character, closing_character) do
    @brackets[opening_character] == closing_character
  end
end
