defmodule GenStackTest do
  use ExUnit.Case

  test "Can create stack" do
    {:ok, stack} = GenStack.new
    assert is_pid(stack)
  end

  test "Can push and pop from stack" do
    {:ok, stack} = GenStack.new

    stack
    |>  GenStack.push("bants")

    assert "bants" == GenStack.pop(stack)
  end

  test "can peek onto the stack" do
    {:ok, stack} = GenStack.new

    stack
    |> GenStack.push("wow")

    assert "wow" == GenStack.peek(stack)
    assert "wow" == GenStack.peek(stack)
  end

  test "can pop from the stack" do
    {:ok, stack} = GenStack.new

    stack
    |> GenStack.push("wow")
    |> GenStack.push("wee")

    assert "wee" == GenStack.pop(stack)
    assert "wow" == GenStack.pop(stack)
  end

  test "can count the items in the stack" do
    {:ok, stack} = GenStack.new

    assert 0 == GenStack.count(stack)

    stack
    |> GenStack.push("1")
    |> GenStack.push("2")

    assert 2 == GenStack.count(stack)

    stack
    |> GenStack.pop

    assert 1 == GenStack.count(stack)
  end

end
