defmodule CraicStack do
  def new do
    ref = Process.spawn(&loop/0, [])
    {:ok, ref}
  end

  def push(stack, value) do
    :not_implemented
  end

  def pop(stack) do
    :not_implemented
  end

  def peek(stack) do
    :not_implemented
  end

  defp loop do
  end

end
