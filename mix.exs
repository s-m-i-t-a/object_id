defmodule ObjectId.MixProject do
  use Mix.Project

  def project do
    [
      app: :object_id,
      version: "0.1.0",
      elixir: "~> 1.6",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:ex_doc, "~> 0.18.1", only: :dev},
      {:credo, "~> 0.9", only: [:dev, :test]},
      {:excoveralls, "~> 0.9", only: :test},
      {:mongodb, "~> 0.4.6"},
      {:result, "~> 1.1"}
    ]
  end
end
