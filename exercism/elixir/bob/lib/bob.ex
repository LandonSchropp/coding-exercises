defmodule Bob do
  def hey(input) do
    cond do
      nothing?(input) -> "Fine. Be that way!"
      question?(input) && yell?(input) -> "Calm down, I know what I'm doing!"
      question?(input) -> "Sure."
      yell?(input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end

  defp question?(input), do: String.ends_with? input, "?"
  defp yell?(input), do: String.upcase(input) == input && String.match?(input, ~r/[[:alpha:]]/)
  defp nothing?(input), do: String.trim(input) == ""
end
