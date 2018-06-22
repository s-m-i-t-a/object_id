defmodule ObjectId.MixProject do
  use Mix.Project

  def project do
    [
      app: :object_id,
      description: "Mongo BSON ObjectID helper functions",
      version: "1.0.1",
      elixir: "~> 1.6",
      elixirc_paths: elixirc_paths(Mix.env()),
      dialyzer: dialyzer_base() |> dialyzer_ptl(System.get_env("SEMAPHORE_CACHE_DIR")),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
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
      {:result, "~> 1.1"},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false}
    ]
  end

  defp package do
    [
      maintainers: [
        "Jindrich K. Smitka <smitka.j@gmail.com>"
      ],
      licenses: ["BSD"],
      links: %{
        "GitHub" => "https://github.com/s-m-i-t-a/object_id"
      }
    ]
  end

  defp dialyzer_base() do
    [plt_add_deps: :transitive]
  end

  defp dialyzer_ptl(base, nil) do
    base
  end

  defp dialyzer_ptl(base, path) do
    base ++
      [
        plt_core_path: path,
        plt_file:
          Path.join(
            path,
            "dialyxir_erlang-#{otp_vsn()}_elixir-#{System.version()}_deps-dev.plt"
          )
      ]
  end

  defp otp_vsn() do
    major = :erlang.system_info(:otp_release) |> List.to_string()
    vsn_file = Path.join([:code.root_dir(), "releases", major, "OTP_VERSION"])

    try do
      {:ok, contents} = File.read(vsn_file)
      String.split(contents, "\n", trim: true)
    else
      [full] ->
        full

      _ ->
        major
    catch
      :error, _ ->
        major
    end
  end
end
