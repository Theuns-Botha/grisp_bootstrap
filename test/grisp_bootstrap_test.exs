defmodule GrispBootstrapTest do
  use ExUnit.Case
  doctest GrispBootstrap

  test "greets the world" do
    assert GrispBootstrap.hello() == :world
  end
end
