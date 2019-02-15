defmodule MonadicForTest do
  use ExUnit.Case
  doctest MonadicFor

  test "greets the world" do
    assert MonadicFor.hello() == :world
  end
end
