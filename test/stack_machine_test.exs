defmodule StackMachineTest do
  use ExUnit.Case
  doctest StackMachine

  test "running an empty program returns an empty stack" do
    code = []
    expected = {:ok, []}
    result = StackMachine.execute(code)

    assert result == expected
  end

  test "running a program returns the result of it" do
    code = [:push, 4, :push, 5, :add]
    expected = {:ok, [9]}
    result = StackMachine.execute(code)

    assert result == expected
  end

  test "a program halting returns the current stack" do
    code = [:halt]
    expected = {:halted, []}
    result = StackMachine.execute(code)

    assert result == expected
  end

  @tag :pending
  test "subroutines are supported"

  @tag :pending
  test "multiple programs can be run"
end
