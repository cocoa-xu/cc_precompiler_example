defmodule CCPrecompilerExample.MixProject do
  use Mix.Project

  @version "0.2.0"
  def project do
    [
      app: :cc_precompiler_example,
      version: @version,
      elixir: "~> 1.12",
      compilers: [:elixir_make] ++ Mix.compilers(),
      make_executable: make_executable(),
      make_makefile: make_makefile(),
      make_nif_filename: "nif",
      make_precompiler: {:nif, CCPrecompiler},
      make_precompiler_priv_paths: ["include_this", "nif.*"],
      make_precompiler_url:
        "https://github.com/cocoa-xu/cc_precompiler_example/releases/download/v#{@version}/@{artefact_filename}",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      cc_precompiler: [
        cleanup: "mycleanup"
      ]
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
      {:elixir_make, "~> 0.7", runtime: false},
      {:cc_precompiler, "~> 0.1", runtime: false, override: true},
      # deps
      {:stb_image, "~> 0.6", github: "elixir-nx/stb_image"},
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
