defmodule CraicStackTest do
  use ExUnit.Case

  test "Can create stack" do
    {:ok, stack} = CraicStack.new
    assert is_pid(stack)
  end

  test "Can push and pop from stack" do
    {:ok, stack} = CraicStack.new

    stack
    |>  CraicStack.push("bants")

    assert "bants" == CraicStack.pop(stack)
  end

  test "can peek onto the stack" do
    {:ok, stack} = CraicStack.new

    stack
    |> CraicStack.push("wow")

    assert "wow" == CraicStack.peek(stack)
    assert "wow" == CraicStack.peek(stack)
  end

  test "can pop from the stack" do
    {:ok, stack} = CraicStack.new

    stack
    |> CraicStack.push("wow")
    |> CraicStack.push("wee")

    assert "wee" == CraicStack.pop(stack)
    assert "wow" == CraicStack.pop(stack)
  end

  test "can count the items in the stack" do
    {:ok, stack} = CraicStack.new

    assert 0 == CraicStack.count(stack)

    stack
    |> CraicStack.push("1")
    |> CraicStack.push("2")

    assert 2 == CraicStack.count(stack)

    stack
    |> CraicStack.pop

    assert 1 == CraicStack.count(stack)
  end

end
