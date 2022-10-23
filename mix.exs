defmodule ExCsv.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_csv,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:csv, " ~> 2.4"}
    ]
  end

  defp escript do
    [main_module: ExCsv.CLI]
  end
end
