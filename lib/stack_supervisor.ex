defmodule StackSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    children = [
      worker(GenStack, [], retart: :transient)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end

end
