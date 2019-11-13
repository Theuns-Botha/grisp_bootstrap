defmodule GrispBlinkTest do
  use ExUnit.Case
  doctest GrispBlink

  test "greets the world" do
    assert GrispBlink.hello() == :world
  end
end
