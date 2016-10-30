defmodule Parallel do
  def map(array, fun) do
    array
    |> Enum.map(&Task.async(fn -> fun.(&1) end))
    |> Enum.map(&Task.await/1)
  end
end

results = [1, 2, 3] |> Parallel.map(fn(el) -> el * el end)

IO.inspect(results) # => [1, 4, 9]
