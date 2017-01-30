defmodule CraicStackTest do
  use ExUnit.Case

  test "Can create stack" do
    {:ok, stack} = CraicStack.new
    assert is_pid(stack)
  end

  test "Can push and pop from stack" do
    {:ok, stack} = CraicStack.new

    stack
    |>  Stack.push "bants"

    assert "bants" == CraicStack.pop(stack)
  end

  test "Can peek onto the stack" do
    {:ok, stack} = CraicStack.new

    stack
    |> CraicStack.push "wow"

    assert "wow" == CraicStack.peek(stack)
    assert "wow" == CraicStack.peek(stack)
  end

end
