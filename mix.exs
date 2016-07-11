defmodule StackMachine.Mixfile do
  use Mix.Project

  def project do
    [
      app: :stack_machine,
      version: "0.0.1",
      elixir: "~> 1.3",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps,
      description: description,
      package: package
    ]
  end

  defp description do
    """
    A basic stack-based virtual machine.
    """
  end

  defp package do
    [
      maintainers: ["Lennart Fridén"],
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/DevL/stack_machine"}
    ]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:earmark, "~> 0.2", only: :dev},
      {:ex_doc, "~> 0.12", only: :dev},
      {:inch_ex, ">= 0.5.3", only: :docs}
    ]
  end
end
