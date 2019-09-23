defmodule Forth do
  @opaque evaluator :: any

  # Defines the default set of words that can be used when evaluating input strings.
  @words %{
    "+" => &+/2,
    "-" => &-/2,
    "*" => &*/2,
    "/" => &div/2
  }

  @doc """
  Create a new evaluator.
  """
  @spec new() :: evaluator
  def new(), do: { [], @words }

  @doc """
  Return the current stack as a string with the element on top of the stack being the rightmost
  element in the string.
  """
  @spec format_stack(evaluator) :: String.t()
  def format_stack(evaluator), do: evaluator |> elem(0) |> Enum.reverse |> Enum.join(" ")

  @doc """
  Evaluate an input string, updating the evaluator state.
  """
  @spec eval(evaluator, String.t()) :: evaluator

  @doc """
  Returns true if the word is known to the evaluator.
  """
  def known_word?(evaluator, word) do
    Enum.member?(Map.keys(@words), word)
  end

  # Parse the string into a list set of operations.
  def eval(evaluator, string) when is_binary(string) do

    # TODO: Determine why \W doesn't work in the regular expression.
    eval(evaluator, String.split(string, ~r/[^\da-z+*\-\/]+/i, trim: true))
  end

  # Base case: When there are no operations, return the evaluator as is.
  def eval(evaluator, []), do: evaluator

  # Recursive case: When there's an operation, evaluate it.
  def eval(evaluator, [ operation | operations ]) do
    cond do
      known_word?(evaluator, operation) -> eval(operate(evaluator, operation), operations)
      String.match?(operation, ~r/^\d+$/) -> eval(push(evaluator, operation), operations)
      true -> raise Error.UnknownWord
    end
  end

  # Pushes the number onto the stack in the evaluator.
  defp push({ stack, words }, number), do: { [ elem(Integer.parse(number), 0) | stack ], words }

  # Guard against division by zero.
  defp operate({ [ 0, _ | _ ], _ }, "/") do
    raise Error.DivisionByZero
  end

  # Evaluate primitive operators.
  defp operate({ [ first, second | stack ], words }, operation) do
    { [ @words[operation].(second, first) | stack ], words }
  end
end
