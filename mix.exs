defmodule OrderJob.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      consolidate_protocols: Mix.env() != :test
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
      {:jason, "~> 1.2"},
      {:ecto, "~> 3.4.5"},
      {:castore, "~> 0.1.0"},
      {:mint, "~> 1.0"},
      {:timex, "~> 3.5"}
    ]
  end
end
