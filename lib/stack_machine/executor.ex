defmodule StackMachine.Executor do
  @vsn "0.0.1"

  def execute(program) do
    execute(program, [])
  end

  defp execute([], stack), do: {:ok, stack}
  defp execute([:push, value | code], stack) do
    execute(code, [value | stack])
  end
  defp execute([:add | code], [a, b | stack]) do
    execute(code, [a + b | stack])
  end
end
