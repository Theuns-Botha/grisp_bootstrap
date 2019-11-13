defmodule GrispBlink.MixProject do
  use Mix.Project

  def project do
    [
      app: :grisp_blink,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      grisp: [
        otp: [version: "22.0"],
        deploy: [
          destination: "{media_path}"
        ]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {GrispBlink.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:grisp, "~> 1.1"},
      {:mix_grisp, "~> 0.1.0", only: :dev}
    ]
  end
end
