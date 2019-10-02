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
  def left({ binary_tree, zipper }), do: { binary_tree, zipper ++ [ :left ] }

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t()) :: Zipper.t() | nil
  def right({ binary_tree, zipper }), do: { binary_tree, zipper ++ [ :right ] }

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
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right(zipper, right) do
  end
end
