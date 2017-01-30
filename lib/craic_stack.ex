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

  @doc false
  def loop(state) do
    store = receive do
      {:push, value} -> [value | state.store]
      {:pop, from} ->
        [head | tail] = state.store
        send(from, {{:pop_reply, head}, self()})
        tail
      {:peek, from} ->
        [head | _tail] = state.store
        send(from, {{:peek_reply, head}, self()})
        state.store
    end
    loop(%{state| store: store})
  end

end
