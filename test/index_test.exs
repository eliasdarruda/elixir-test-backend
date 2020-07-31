defmodule INDEXTest do
  use ExUnit.Case
  doctest INDEX

  test "greets the world" do
    assert INDEX.hello() == :world
  end
end
