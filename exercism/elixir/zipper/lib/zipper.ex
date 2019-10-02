defmodule Zipper do
  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(binary_tree), do: { binary_tree, [] }

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Zipper.t()) :: BinTree.t()
  def to_tree({ binary_tree, _ }), do: binary_tree

  @doc """
  Get the value of the focus node.
  """
  @spec value(Zipper.t()) :: any
  def value({ binary_tree, [] }), do: binary_tree.value

  def value({ binary_tree, [ move | zipper ] }) do
    value({ Map.get(binary_tree, move), zipper })
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Zipper.t()) :: Zipper.t() | nil
  def left(zipper), do: add_move(zipper, :left)

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t()) :: Zipper.t() | nil
  def right(zipper), do: add_move(zipper, :right)

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Zipper.t()) :: Zipper.t() | nil
  def up({ binary_tree, [] }), do: nil
  def up({ binary_tree, zipper }), do: { binary_tree, Enum.drop(zipper, -1) }

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Zipper.t(), any) :: Zipper.t()
  def set_value(zipper, value) do
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_left(zipper, left) do
    add_move(zipper, left)
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right(zipper, right) do
  end

  # Safely adds a move to the zipper. If the move is illegal, this method will return nil.
  defp add_move(zipper, move)
  defp add_move({ %{ left: nil }, [] }, :left), do: nil
  defp add_move({ %{ right: nil }, [] }, :right), do: nil
  defp add_move({ binary_tree, [] }, move), do: { binary_tree, [ move ] }

  defp add_move({ binary_tree, [ current_move | moves ] }, move) do
    child_zipper = add_move({ Map.get(binary_tree, current_move), moves }, move)

    if child_zipper != nil do
      { binary_tree, [ current_move | elem(child_zipper, 1) ] }
    else
      nil
    end
  end
end
