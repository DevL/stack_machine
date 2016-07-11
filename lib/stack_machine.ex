defmodule StackMachine do
  def execute(code) do
    {:ok, _pid} = Agent.start_link(fn -> %{subroutines: extract_subroutines(code)} end, name: __MODULE__)
    _execute(code, [])
  end

  def extract_subroutines(code) do
    _extract_subroutines(code, %{})
  end

  defp _extract_subroutines([], subroutines), do: subroutines
  defp _extract_subroutines([:label, label | code], subroutines) do
    _extract_subroutines(code, Map.put(subroutines, label, code))
  end
  defp _extract_subroutines([_ | code], subroutines) do
    _extract_subroutines(code, subroutines)
  end

  defp _execute([], stack), do: stack
  defp _execute([:push | [value | code]], stack) do
    _execute(code, [value | stack])
  end
  defp _execute([:add | code], [a | [b | rest_of_stack]]) do
    _execute(code, [a + b | rest_of_stack])
  end
  defp _execute([:multiply | code], [a | [b | rest_of_stack]]) do
    _execute(code, [a * b | rest_of_stack])
  end
  defp _execute([:label | [_label | code]], stack) do
    _execute(code, stack)
  end
  defp _execute([:inspect | code], stack) do
    IO.puts hd(stack)
    _execute(code, stack)
  end
  defp _execute([:call | code], [label | stack]) do
    new_stack = _execute(subroutine(label), stack)
    _execute(code, new_stack)
  end
  defp _execute([:return | _code], stack), do: stack
  defp _execute([:halt | _code], _stack), do: :halted

  defp subroutine(label) do
    Agent.get(__MODULE__, fn(state) -> state.subroutines[label] end)
  end
end

# code = [:push, 4, :push, 5, :add, :push, 2, :multiply]
# StackMachine.execute code

# code = [:push, 4, :push, 5, :push, :add_and_double, :call, :inspect, :halt, :label, :add_and_double, :add, :push, 2, :multiply, :return]
# StackMachine.execute code

# code = [:push, 0, :label, :increment_and_inspect, :push, 1, :add, :inspect, :push, :increment_and_inspect, :call]
# StackMachine.execute code
