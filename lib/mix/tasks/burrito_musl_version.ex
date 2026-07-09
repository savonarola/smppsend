defmodule Mix.Tasks.Burrito.Musl.Version do
  @moduledoc "Export musl version for Burrito builds: `mix help burrito_musl_version`"
  @shortdoc "Print musl version for burrito builds"
  use Mix.Task

  @impl Mix.Task
  def run(_) do
    IO.puts(Mix.Project.config()[:burrito_musl_version])
  end
end
