defmodule CcPrecompilerExampleTest do
  use ExUnit.Case

  test "greets the world" do
    assert :cc_precompiler_example.hello_world() == ~c"hello world"
  end
end
