import Supervisor.Spec

children = [
  supervisor(Task.Supervisor, [[name: :sup]])
]

# In this example we want to kill the task supervisor to test
# if it will kill its children. For this we need one more supervisor
# that will prevent our application from dying when we kill the task
# supervisor.
Supervisor.start_link(children, strategy: :one_for_one)

task = Task.Supervisor.async_nolink(:sup, fn ->
  (1..1000) |> Enum.each(fn(_) ->
    IO.puts "Alive"
    :timer.sleep(500)
  end)
end)

:timer.sleep(3000)

IO.puts "Killing task supervisor"
Supervisor.stop(:sup, :normal)

:timer.sleep(3000)

# Output:
#
# Alive
# Alive
# Alive
# Alive
# Alive
# Alive
# Killing task supervisor
#
# Press ENTER or type command to continue
