defmodule CraicStack do

  def new do
    state = %{store: [], count: 0}
    ref = Process.spawn(__MODULE__, :loop, [state], [])
    {:ok, ref}
  end

  def push(stack, value) do
    send(stack, {:push, value})
    stack
  end

  def pop(stack) do
    send(stack, {:pop, self()})
    receive do
      {{:pop_reply, value}, ^stack} -> value
    end
  end

  def peek(stack) do
    send(stack, {:peek, self()})
    receive do
      {{:peek_reply, value}, ^stack} -> value
    end
  end

  def count(stack) do
    send(stack, {:count, self()})
    receive do
      {{:count_reply, value}, ^stack} -> value
    end
  end

  @doc false
  def loop(state) do
    loop(receive do
      {:push, value} -> handle({:push, value}, state)
      {:pop, from}   -> handle(:pop, from, state)
      {:peek, from}  -> handle(:peek, from, state)
      {:count, from} -> handle(:count, from, state)
    end)
  end

  defp handle({:push, value}, state) do
    %{state | store: [value | state.store],
              count: state.count + 1}
  end

  defp handle(:pop, from, state) do
    [head | tail] = state.store
    send(from, {{:pop_reply, head}, self()})
    %{state | store: tail,
              count: state.count - 1}
  end

  defp handle(:peek, from, state) do
    [head | _tail] = state.store
    send(from, {{:peek_reply, head}, self()})
    state
  end

  defp handle(:count, from, state) do
    send(from, {{:count_reply, state.count}, self()})
    state
  end

end
