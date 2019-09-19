defmodule RobotSimulator do

  @directions [ :north, :east, :south, :west ]

  @invalid_direction { :error, "invalid direction" }
  @invalid_position { :error, "invalid position" }
  @invalid_instruction { :error, "invalid instruction" }

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ { 0, 0 })

  # Validate the direction and position.
  def create(direction, _) when direction not in @directions, do: @invalid_direction
  def create(_, position) when not is_tuple(position), do: @invalid_position
  def create(_, position) when tuple_size(position) != 2, do: @invalid_position
  def create(_, { x, _ }) when not is_integer(x), do: @invalid_position
  def create(_, { _, y }) when not is_integer(y), do: @invalid_position

  # Represent the robot as a tuple.
  def create(direction, position), do: { direction, position }

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction({ direction, _ }), do: direction

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position({ _, position }), do: position

  @doc """
  Turns a robot to the right.
  """
  def turn_right({ direction, position }), do: { Direction.rotate(direction, 1), position }

  @doc """
  Turns a robot to the left.
  """
  def turn_left({ direction, position }), do: { Direction.rotate(direction, -1), position }

  @doc """
  Advances a robot forward one space.
  """
  def advance({ direction, { x, y } }) do
    { vector_x, vector_y } = Direction.to_vector(direction)
    { direction, { x + vector_x, y + vector_y } }
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any

  # Sanitization: Validate the instructions and break them into a list.
  def simulate(robot, instructions) when is_binary(instructions) do
    if String.match? instructions, ~r/[^LRA]/ do
      @invalid_instruction
    else
      simulate(robot, String.graphemes(instructions))
    end
  end

  # Base case: There are no more instructions.
  def simulate(robot, []), do: robot

  # Recursive cases: The robot moves left, the robot moves right or the robot advances.
  def simulate(robot, [ "L" | tail ]), do: simulate(turn_left(robot), tail)
  def simulate(robot, [ "R" | tail ]), do: simulate(turn_right(robot), tail)
  def simulate(robot, [ "A" | tail ]), do: simulate(advance(robot), tail)
end
