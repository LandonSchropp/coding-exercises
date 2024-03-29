defmodule Forth do
  @opaque evaluator :: { list, %{ optional(String.t()) => any } }

  @doc """
  Create a new evaluator.
  """
  @spec new() :: evaluator
  def new() do
    {
      [],
      %{
        "+" => decorate_operation(&[ &1 + &2 ]),
        "-" => decorate_operation(&[ &1 - &2 ]),
        "*" => decorate_operation(&[ &1 * &2 ]),
        "/" => decorate_operation(fn
          (_, 0) -> raise Forth.DivisionByZero
          (a, b) -> [ div(a, b) ]
        end),
        "dup" => decorate_operation(&[ &1, &1 ]),
        "drop" => decorate_operation(fn(_) -> [] end),
        "swap" => decorate_operation(&[ &1, &2 ]),
        "over" => decorate_operation(&[ &1, &2, &1 ]),
      }
    }
  end

  @doc """
  Return the current stack as a string with the element on top of the stack being the rightmost
  element in the string.
  """
  @spec format_stack(evaluator) :: String.t()
  def format_stack({ stack, _ }), do: stack |> Enum.reverse |> Enum.join(" ")

  @doc """
  Evaluate an input string, updating the evaluator state.
  """
  @spec eval(evaluator, String.t()) :: evaluator

  # Parse the string into a list set of operations.
  def eval(evaluator, string) when is_binary(string) do

    # TODO: Determine why \W doesn't work in the regular expression.
    operations = string
    |> String.downcase
    |> String.split(~r/[[:space:][:cntrl:]]+/u, trim: true)
    |> Enum.map(fn word -> parse_if_integer(word) end)

    eval(evaluator, operations)
  end

  # Base case: When there are no operations, return the evaluator as is.
  def eval(evaluator, []), do: evaluator

  # Recursive case: When the operation is a number, add it to the stack.
  def eval({ stack, words }, [ operation | operations ]) when is_number(operation) do
    eval({ [ operation | stack ], words }, operations)
  end

  # Recursive case: When the operation is defining a new word, add the word to the words map.
  def eval({ stack, words }, [ ":" | operations ]) do

    # Extract the word and word operations.
    {
      [ word | word_operations ],
      [ ";" | operations ]
    } = Enum.split_while(operations, &(&1 != ";"))

    # Ensure the word is not a number.
    if is_number word do
      raise Forth.InvalidWord
    end

    # Update the words with thew new operation.
    words = Map.put(words, word, fn (evaluator) -> eval(evaluator, word_operations) end)

    # Recurse with the updated words.
    eval({ stack, words }, operations)
  end

  # Recursive case: When the operation is a word, evaluate it.
  def eval({ _, words } = evaluator, [ operation | operations ]) do

    if Map.has_key?(words, operation) do
      eval(words[operation].(evaluator), operations)
    else
      raise Forth.UnknownWord, word: operation
    end
  end

  # Parses the word as an integer, but only if contains only digits.
  defp parse_if_integer(word) do
    if String.match? word, ~r/^\d+$/ do
      elem(Integer.parse(word), 0)
    else
      word
    end
  end

  # Creates an operation that modifies the stack in the evaluator. This function uses the arity of
  # the provided function to determine if the stack has underflowed.
  defp decorate_operation(operation_function) do
    arity = Function.info(operation_function)[:arity]

    fn ({ stack, operations }) ->

      # Ensure the stack has enough elements to apply the operation function.
      if length(stack) < arity do
        raise Forth.StackUnderflow
      end

      { parameters, tail } = Enum.split(stack, arity)
      { apply(operation_function, Enum.reverse parameters) ++ tail, operations }
    end
  end

  defmodule StackUnderflow do
    defexception []
    def message(_), do: "stack underflow"
  end

  defmodule InvalidWord do
    defexception word: nil
    def message(e), do: "invalid word: #{inspect(e.word)}"
  end

  defmodule UnknownWord do
    defexception word: nil
    def message(e), do: "unknown word: #{inspect(e.word)}"
  end

  defmodule DivisionByZero do
    defexception []
    def message(_), do: "division by zero"
  end
end
