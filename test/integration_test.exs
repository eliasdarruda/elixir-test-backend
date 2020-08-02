defmodule IntegrationTest do
  use ExUnit.Case
  use Timex

  test "process order integration (w/ HTTP request)" do
    OrderJob.init()
  end
end
