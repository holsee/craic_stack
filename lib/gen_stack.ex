defmodule GenStack do
  use GenServer

  # API

  def new do
    state = %{store: [], count: 0}
    GenServer.start(__MODULE__, state)
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

  def count(stack) do
    :not_implemented
  end

  # GenServer Callbacks

end
