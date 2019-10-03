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
  def set_left({ binary_tree, [ move | moves ] }, left) do
    # set_left
  end

  def set_left({ binary_tree, [] }, left) do
    # IO.inspect(binary_tree, label: "\n\ntree")
    # IO.inspect(left, label: "left")
    # { %{ binary_tree | left: left }, moves }
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right({ binary_tree, moves }, right), do: { %{ binary_tree | right: right }, moves }
  #
  # # Safely adds a move to the zipper. If the move is illegal, this method will return nil.
  # defp add_move(zipper, move)
  # defp add_move({ %{ left: nil }, [] }, :left), do: nil
  # defp add_move({ %{ right: nil }, [] }, :right), do: nil
  # defp add_move({ binary_tree, [] }, move), do: { binary_tree, [ move ] }
  #
  # defp add_move({ binary_tree, [ current_move | moves ] }, move) do
  #   child_zipper = add_move({ Map.get(binary_tree, current_move), moves }, move)
  #
  #   if child_zipper != nil do
  #     { binary_tree, [ current_move | elem(child_zipper, 1) ] }
  #   else
  #     nil
  #   end
  # end
  #
  # # Fetches the node following the given moves. If the node does not exist, this function returns
  # # nil.
  # defp node(binary_tree, []), do: binary_tree
  # defp node(binary_tree, [ move | moves ]), do: node(Map.get(binary_tree, move), moves)
  #
  # # Replaces a node after following the given set of moves.
  # defp replace_node(binary_tree, moves, node)
  #
  # defp replace_node(_, [], node) do
  #   node
  # end
  #
  # defp replace_node(binary_tree, [ :left | moves ], node) do
  #   %{ binary_tree | left: replace_node(binary_tree.left, moves, node) }
  # end
  #
  # defp replace_node(binary_tree, [ :right | moves ], node) do
  #   %{ binary_tree | right: replace_node(binary_tree.right, moves, node) }
  # end
  #
  # # Ensures the Zipper is valid. If it's not, this method returns nil.
  # defp sanitize(zipper)
end
