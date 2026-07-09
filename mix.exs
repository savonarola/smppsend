defmodule Smppsend.Mixfile do
  use Mix.Project

  @burrito_otp_version "29.0.3"
  @burrito_ssl_version "3.5.1"
  @burrito_musl_version "1.2.5"

  def project do
    [
      app: :smppsend,
      version: "0.1.24",
      elixir: "~> 1.14",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      escript: escript(),
      test_coverage: [tool: ExCoveralls],
      releases: releases(),
      burrito_otp_version: @burrito_otp_version,
      burrito_ssl_version: @burrito_ssl_version,
      burrito_musl_version: @burrito_musl_version
    ]
  end

  def application do
    [
      extra_applications: [:logger, :runtime_tools, :xmerl],
      mod: {SMPPSend, []}
    ]
  end

  def cli do
    [
      preferred_envs: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  def releases do
    [
      smppsend: [
        steps: [:assemble, &Burrito.wrap/1],
        burrito: [
          targets: [
            linux_aarch64: [
              os: :linux,
              cpu: :aarch64
            ],
            linux_x86_64: [
              os: :linux,
              cpu: :x86_64
            ],
            darwin_aarch64: [
              os: :darwin,
              cpu: :aarch64
            ]
          ]
        ]
      ]
    ]
  end

  defp deps do
    [
      {:smppex, "~> 3.3"},
      {:dye, "~> 0.4.0"},
      {:codepagex, "~> 0.1.6"},
      {:burrito, "~> 1.5"},
      {:excoveralls, "~> 0.18.5", only: :test},
      {:mox, "~> 1.0", only: :test}
    ]
  end

  def escript do
    [main_module: SMPPSend]
  end
end
