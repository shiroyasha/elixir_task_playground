task = Task.async fn ->
  1 + 2
end

result = Task.await(task)

IO.inspect(result) # => 3
