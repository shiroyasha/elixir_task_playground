t1 = Task.async fn -> 1 * 1 end
t2 = Task.async fn -> 1 * 10 end
t3 = Task.async fn -> 1 * 1000 end

tasks = [t1, t2, t3]

result = tasks |> Enum.map(&Task.await/1)

IO.inspect(result) # => [1, 10, 1000]
