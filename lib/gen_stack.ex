defmodule GenStack do
  use GenServer

  # API

  def new do
    state = %{store: [], count: 0}
    GenServer.start(__MODULE__, state)
  end

  def push(stack, value) do
    GenServer.cast(stack, {:push, value})
    stack
  end

  def pop(stack) do
    GenServer.call(stack, :pop)
  end

  def peek(stack) do
    GenServer.call(stack, :peek)
  end

  def count(stack) do
    :not_implemented
  end

  # GenServer Callbacks

  def handle_cast({:push, value}, state) do
    {:noreply, %{state | store: [value | state.store],
                         count: state.count + 1}}
  end

  def handle_call(:pop, _from, state) do
    [head | tail] = state.store
    {:reply, head, %{state | store: tail,
                             count: state.count - 1}}
  end

  def handle_call(:peek, _from, state) do
    [head | _] = state.store
    {:reply, head, state}
  end

end
