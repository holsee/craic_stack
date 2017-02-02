defmodule StackApp do
  use Application

  def start(_type, _args) do
    IO.puts "Starting #{__MODULE__}..."
    StackSupervisor.start_link
  end
end
