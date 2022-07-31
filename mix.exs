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
      cc_precompile_base_url: "https://github.com/cocoa-xu/cc_precompiler_example/downloads/releases/v#{@version}",
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
      {:elixir_make, "~> 0.6", runtime: false, github: "cocoa-xu/elixir_make", branch: "cx-fennec_precompile"},
      {:cc_precompiler, "~> 0.1.0", runtime: false, github: "cocoa-xu/cc_precompiler"}
    ]
  end
end
