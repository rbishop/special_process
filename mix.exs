defmodule SpecialProcess.Mixfile do
  use Mix.Project

  def project do
    [app: :special_process,
     version: "0.1.0",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: [],
     package: package,
     name: "Special Process",
     homepage_url: "https://github.com/rbishop/special_process",
     description: "OTP Special Process helper",
     docs: [readme: "README.md", main: "README",
            source_url: "https://github.com/rbishop/special_process"]]
  end

  def application do
    [applications: [:logger]]
  end

  defp package do
    [licenses: ["Apache 2"],
     contributors: ["Richard Bishop"],
     links: [github: "https://github.com/rbishop/special_process"]]
  end
end
