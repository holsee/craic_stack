defmodule CraicStack do

  def new do
    state = %{store: []}
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
    end)
  end

  defp handle({:push, value}, state) do
    %{state | store: [value | state.store]}
  end

  defp handle(:pop, from, state) do
    [head | tail] = state.store
    send(from, {{:pop_reply, head}, self()})
    %{state | store: tail}
  end

  defp handle(:peek, from, state) do
    [head | _tail] = state.store
    send(from, {{:peek_reply, head}, self()})
    state
  end

end
