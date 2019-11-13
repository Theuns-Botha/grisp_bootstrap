defmodule GrispBootstrap.MixProject do
  use Mix.Project

  def project do
    [
      app: :grisp_bootstrap,
      version: version(),
      elixir: "~> 1.9",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      source_url: "https://github.com/Theuns-Botha/grisp_bootstrap",
      package: package(),
      preferred_cli_env: [
        "publish_archives": :prod
      ]
    ]
  end

  defp description do
    "A bootstrap tool for Elixir GRiSP projects"
  end

  defp package do
    [
      name: :grisp_bootstrap,
      licenses: ["Apache 2.0"],
      maintainers: ["Theuns Botha"],
      links: %{
        "GitHub" => "https://github.com/Theuns-Botha/grisp_bootstrap"
      }
    ]
  end

  def version, do: String.trim(File.read!("VERSION"))

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:eliver, "~> 2.0.0", only: :dev}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
