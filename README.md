# SpecialProcess

For those times when GenServer and GenEvent just aren't what you need.

## What is a special process?

A special process is a process that is OTP compliant but is not one of the core
behaviours. These are useful for when you need performance or one of the
existing behaviours just doesn't suit your needs. The benefits of using a
special process is that the process can be part of a Supervision tree and will
emit and handle proper system and error logger messages.

You can see the Erlang/OTP documentation for more about [special
processes](http://www.erlang.org/doc/design_principles/spec_proc.html).

## Usage

```elixir
defmodule ProblemChild do
  use SpecialProcess

  def start_link do
    SpecialProcess.start_link(__MODULE__, :loop, [])
  end

  def loop do
    IO.puts "Yay I'm looping!"
    :timer.sleep(1000)
    loop
  end
end


import Supervisor.Spec

children = [worker(ProblemChild, [])]

Supervisor.start_link(children, [strategy: :one_for_one])
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add special_process to your list of dependencies in `mix.exs`:

        def deps do
          [{:special_process, "~> 0.0.1"}]
        end

  2. Ensure special_process is started before your application:

        def application do
          [applications: [:special_process]]
        end
