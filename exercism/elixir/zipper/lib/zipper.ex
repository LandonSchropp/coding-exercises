defmodule Zipper do

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(tree), do: [ { tree, nil } ]

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Zipper.t()) :: BinTree.t()
  def to_tree([ { tree, nil } ]), do: tree
  def to_tree(zipper), do: to_tree(up(zipper))

  @doc """
  Get the value of the focus node.
  """
  @spec value(Zipper.t()) :: any
  def value([ { tree, _ } | moves ]), do: tree.value

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Zipper.t()) :: Zipper.t() | nil
  def left([ { %{ left: nil }, _ } | _ ] = zipper), do: nil
  def left([ { tree, _ } | _ ] = zipper), do: [ { tree.left, :left } | zipper ]

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t()) :: Zipper.t() | nil
  def right([ { %{ right: nil }, _ } | _ ] = zipper), do: nil
  def right([ { tree, _ } | _ ] = zipper), do: [ { tree.right, :right } | zipper ]

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Zipper.t()) :: Zipper.t() | nil
  def up([ { _, nil } ]), do: nil

  def up([ { tree, move }, { parent_tree, parent_move } | ancestors ]) do
    [ { Map.put(parent_tree, move, tree), parent_move } | ancestors ]
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Zipper.t(), any) :: Zipper.t()
  def set_value([ { tree, move } | ancestors ], value) do
    [ { Map.put(tree, :value, value), move } | ancestors ]
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_left([ { tree, move } | ancestors ], left) do
    [ { Map.put(tree, :left, left), move } | ancestors ]
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right([ { tree, move } | ancestors ], right) do
    [ { Map.put(tree, :right, right), move } | ancestors ]
  end
end
