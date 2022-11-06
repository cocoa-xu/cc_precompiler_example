defmodule CCPrecompilerExample.MixProject do
  use Mix.Project

  @version "0.1.1"
  def project do
    [
      app: :cc_precompiler_example,
      version:
        if Mix.env() == :prod do
          @version
        else
          "#{@version}-dev"
        end,
      elixir: "~> 1.12",
      compilers: [:elixir_make] ++ Mix.compilers(),
      make_executable: make_executable(),
      make_makefile: make_makefile(),
      make_nif_filename: "nif",
      make_precompiler: CCPrecompiler,
      make_precompiler_priv_paths: ["include_this", "nif.*"],
      make_precompiled_url:
        "https://github.com/cocoa-xu/cc_precompiler_example/releases/download/v#{@version}/@{artefact_filename}",
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
      # compilation
      {:elixir_make, "~> 0.6", runtime: false, github: "cocoa-xu/elixir_make", branch: "cx-improve-precompiler"},
        # path: "../elixir_make", override: true},
      {:cc_precompiler, "~> 0.1.0", runtime: false, github: "cocoa-xu/cc_precompiler"},
      # deps
      {:stb_image, "~> 0.5", github: "cocoa-xu/stb_image"},
      {:castore, "~> 0.1"},
    ]
  end

  defp make_executable() do
    case :os.type() do
      {:win32, _} -> "nmake"
      _ -> "make"
    end
  end

  defp make_makefile() do
    case :os.type() do
      {:win32, _} -> "Makefile.win"
      _ -> "Makefile"
    end
  end
end
