defmodule StackSupervisorTest do
  use ExUnit.Case

  test "Can start a stack supervisor" do
    {:ok, stack_sup} = StackSupervisor.start_link
    assert is_pid(stack_sup)
  end

  test "Can start a supervised stack" do
    {:ok, stack_sup} = StackSupervisor.start_link
    assert [] == Supervisor.which_children(stack_sup) # simple_one_to_one
    {:ok, stack} = Supervisor.start_child(stack_sup, [])
    assert [{_, ^stack, _, [GenStack]}] = Supervisor.which_children(stack_sup)
  end

end
