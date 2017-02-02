defmodule CraicStack do

  def new(opts \\ []), do: Supervisor.start_child(StackSupervisor, [opts])

  def push(stack, value), do: GenStack.push(stack, value)

  def pop(stack), do: GenStack.pop(stack)

  def peek(stack), do: GenStack.peek(stack)

  def count(stack), do: GenStack.count(stack)

end
