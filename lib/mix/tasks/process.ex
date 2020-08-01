defmodule Mix.Tasks.Process do
  use Mix.Task

  @shortdoc "Runs the OrderJob.init/1 function"
  def run(_) do
    IO.puts("Starting task for order processing...")

    OrderJob.init() |> IO.inspect()

    IO.puts("Task finished!")
  end
end
