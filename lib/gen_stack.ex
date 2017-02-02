defmodule GenStack do
  use GenServer

  @default_state %{store: [], count: 0}

  # API

  def new, do: start()

  def start(opts \\ []) do
    GenServer.start_link(__MODULE__, @default_state, opts)
  end

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, @default_state, opts)
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
    GenServer.call(stack, :count)
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

  def handle_call(:count, _from, state) do
    {:reply, state.count, state}
  end

end
