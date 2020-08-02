defmodule Mix.Tasks.Process do
  use Mix.Task

  @shortdoc "Runs the OrderJob.init/1 function"
  def run(_) do
    IO.puts("Starting task to process a new order...")

    :ok = OrderJob.init()

    IO.puts("Server responded with an OK")
    IO.puts("Task finished!")
  end
end
