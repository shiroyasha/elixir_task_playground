t1 = Task.async fn -> 1 * 1 end
t2 = Task.async fn -> :timer.sleep(1000) end

tasks = [t1, t2]

result = tasks |> Enum.map(fn(task) -> Task.await(task, 500) end)

# ** (exit) exited in: Task.await(%Task{owner: #PID<0.48.0>, pid: #PID<0.52.0>, ref: #Reference<0.0.2.70>}, 500)
#     ** (EXIT) time out
#     (elixir) lib/task.ex:336: Task.await/2
#     (elixir) lib/enum.ex:1088: Enum."-map/2-lists^map/1-0-"/2
#     (elixir) lib/enum.ex:1088: Enum."-map/2-lists^map/1-0-"/2
#     004-timeout.ex:6: (file)
#     (elixir) lib/code.ex:363: Code.require_file/2

# If the timeout is exceeded, await will exit; however, the task will
# continue to run. When the calling process exits, its exit signal
# will terminate the task if it is not trapping exits.
#
# This behaviour makes sense becase the caller could not satisfy the
# time constraint and it can't produce a meaningfull result.
