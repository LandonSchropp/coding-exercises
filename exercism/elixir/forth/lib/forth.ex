defmodule Forth do
  @opaque evaluator :: any

  @doc """
  Create a new evaluator.
  """
  @spec new() :: evaluator
  def new() do
    { [], %{} }
    |> add_word("+", 2, &Operation.add/1)
    |> add_word("-", 2, &Operation.subtract/1)
    |> add_word("*", 2, &Operation.multiply/1)
    |> add_word("/", 2, &Operation.divide/1)
    |> add_word("dup", 1, &Operation.duplicate/1)
    |> add_word("drop", 1, &Operation.drop/1)
    |> add_word("swap", 2, &Operation.swap/1)
    |> add_word("over", 2, &Operation.over/1)
  end

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

  # Parse the string into a list set of operations.
  def eval(evaluator, string) when is_binary(string) do

    operations = string
    |> String.downcase
    |> String.split(~r/[^\da-z+*\-\/]+/, trim: true)
    |> Enum.map(fn word -> parse_if_integer(word) end)

    # TODO: Determine why \W doesn't work in the regular expression.
    # TODO: Parse anything that looks like a number into a number so it can be pattern matched.
    eval(evaluator, operations)
  end

  # Base case: When there are no operations, return the evaluator as is.
  def eval(evaluator, []), do: evaluator

  # Recursive case: When the value is a number, add it to the stack.
  def eval({ stack, operations }, [ number | words ]) when is_number(number) do
    eval({ [ number | stack ], operations }, words)
  end

  # Recursive case: When there's an operation, evaluate it.
  def eval({ stack, operations }, [ word | words ]) do
    if Map.has_key?(operations, word) do
      eval({ operations[word].(stack), operations }, words)
    else
      raise Error.UnknownWord
    end
  end

  # Adds a word to the evaluator.
  defp add_word({ stack, operations }, word, arity, operation) do
    {
      stack,
      Map.put(operations, word, fn
        stack when length(stack) < arity -> raise Error.StackUnderflow
        stack -> operation.(stack)
      end)
    }
  end

  # Parses the word as an integer, but only if contains only digits.
  defp parse_if_integer(word) do
    if String.match? word, ~r/^\d+$/ do
      elem(Integer.parse(word), 0)
    else
      word
    end
  end
end
