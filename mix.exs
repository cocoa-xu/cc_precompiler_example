defmodule CCPrecompilerExample.MixProject do
  use Mix.Project

  @version "0.1.0"
  def project do
    [
      app: :cc_precompiler_example,
      version: (if Mix.env() == :prod do @version else "#{@version}-dev" end),
      elixir: "~> 1.12",
      compilers: [:elixir_make] ++ Mix.compilers(),
      make_nif_filename: "nif",
      make_precompiler: CCPrecompiler,
      make_precompiled_url: "https://github.com/cocoa-xu/cc_precompiler_example/releases/download/v@{version}/@{artefact_filename}",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      # todo: change this to hex.pm once elixir-lang/elixir_make#56 is merged
      {:elixir_make, "~> 0.6", runtime: false, github: "cocoa-xu/elixir_make", branch: "cx-improve-precompiler"},
      {:cc_precompiler, "~> 0.1.0", runtime: false, github: "cocoa-xu/cc_precompiler"}
    ]
  end
end
