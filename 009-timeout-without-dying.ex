{:ok, sup} = Task.Supervisor.start_link

t1 = Task.Supervisor.async_nolink sup, fn -> 1 * 10 end
t2 = Task.Supervisor.async_nolink sup, fn -> :timer.sleep(1000) end

tasks = [t1, t2]

results = tasks |> Enum.map(fn(task) -> Task.yield(task, 500) end)

# brutal kill all tasks
tasks |> Enum.each(&Task.Supervisor.terminate_child(sup, &1.pid))

IO.inspect results

# => [
#   {:ok, 10},
#   nil,
# ]
