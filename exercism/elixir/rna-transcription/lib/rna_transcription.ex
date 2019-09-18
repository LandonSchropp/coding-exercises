defmodule RnaTranscription do

  @nucleotide_pairs %{ ?G => ?C, ?C => ?G, ?T => ?A, ?A => ?U }

  @doc """
  Transcribes a character list representing DNA nucleotides to RNA.
  """
  @spec to_rna([char]) :: [char]
  def to_rna([]), do: []
  def to_rna([ head | tail ]), do: [ @nucleotide_pairs[head] | to_rna(tail) ]
end
