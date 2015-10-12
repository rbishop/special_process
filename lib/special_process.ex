defmodule SpecialProcess do

  defmacro __using__(_) do
    quote location: :keep do

      @doc false
      def start_link do
        :proc_lib.start_link(__MODULE__, :init, [self])
      end

      @doc false
      def init(parent) do
        IO.puts "Initing"
        Process.register(self, __MODULE__)
        debug = :sys.debug_options([])
        :proc_lib.init_ack(parent, {:ok, self})
        loop(parent, debug, [])
      end

      @doc false
      def loop(parent, debug, state) do
        receive do
          {:system, from, request} ->
            :sys.handle_system_msg(request, from, parent, __MODULE__, debug, state)
          msg ->
            IO.puts "Received: #{inspect(msg)}"
            loop(parent, debug, state)
        end
      end

      @doc false
      def system_continue(parent, debug, state) do
        loop(parent, debug, state)
      end

      @doc false
      def system_terminate(reason, _parent, _debug, _state) do
        IO.inspect reason
        IO.puts "Terminating!"
        exit(reason)
      end

      @doc false
      def write_debug(_device, event, name) do
        IO.puts("Event: #{name}")
      end

      @doc false
      def system_code_change(state, _mod, _old_version, _extra) do
        {:ok, state}
      end

      defoverridable [init: 1, system_code_change: 4, system_continue: 3, 
                      system_terminate: 4, write_debug: 3]
    end
  end
end
