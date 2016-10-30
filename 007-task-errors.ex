{:ok, sup} = Task.Supervisor.start_link

t1 = Task.Supervisor.async_nolink sup, fn -> 1/2 end
t2 = Task.Supervisor.async_nolink sup, fn -> 1/1 end
t3 = Task.Supervisor.async_nolink sup, fn -> throw "noup" end

tasks = [t1, t2, t3]

result = tasks |> Enum.map(&Task.yield/1)

IO.inspect(result)

# => [
#   {:ok, 0.5},
#   {:ok, 1.0},
#   {:exit, {{:nocatch, "noup"}, ...}
# ]
