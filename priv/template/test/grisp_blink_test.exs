defmodule <%= app_mod %>Test do
  use ExUnit.Case
  doctest <%= app_mod %>

  test "greets the world" do
    assert <%= app_mod %>.hello() == :world
  end
end
