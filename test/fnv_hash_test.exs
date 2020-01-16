defmodule FnvHashTest do
  use ExUnit.Case
  doctest FnvHash

  test "fnv64a" do
    assert FnvHash.fnv64a("hello.world") == 1_773_339_632_313_245_565
  end
end
