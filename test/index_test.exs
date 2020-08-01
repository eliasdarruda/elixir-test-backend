defmodule INDEXTest do
  use ExUnit.Case

  test "gets raw json from index" do
    json = INDEX.init()

    assert Map.get(json, "id") == 9_987_071
  end
end
