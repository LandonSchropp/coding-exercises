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

  @doc """
  Returns true if the word is known to the evaluator.
  """
  def known_word?({ stack, operations }, word) do
    Enum.member?(Map.keys(operations), word)
  end

  # Parse the string into a list set of operations.
  def eval(evaluator, string) when is_binary(string) do

    operations = string
    |> String.downcase
    |> String.split(~r/[^\da-z+*\-\/]+/, trim: true)

    # TODO: Determine why \W doesn't work in the regular expression.
    # TODO: Parse anything that looks like a number into a number so it can be pattern matched.
    eval(evaluator, operations)
  end

  # Base case: When there are no operations, return the evaluator as is.
  def eval(evaluator, []), do: evaluator

  # Recursive case: When there's an operation, evaluate it.
  def eval(evaluator, [ word | words ]) do
    cond do
      known_word?(evaluator, word) -> eval(operate(evaluator, word), words)
      String.match?(word, ~r/^\d+$/) -> eval(push(evaluator, word), words)
      true -> raise Error.UnknownWord
    end
  end

  # Pushes the number onto the stack in the evaluator.
  defp push({ stack, operations }, number) do
    { [ elem(Integer.parse(number), 0) | stack ], operations }
  end

  # Evaluate operations defined in the words hash.
  defp operate({ stack, operations }, word) do
    { operations[word].(stack), operations }
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
end
