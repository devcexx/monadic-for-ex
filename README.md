# MonadicFor

Scala-style monadic for...yield structure for Elixir.

Scala:
``` scala
def divide(x: Int, y: Int): Try[(Int, Int)] = {
  if (y != 0) Success((x / y, x % y))
  else Failure(new ArithmeticException("Cannot divide by zero!"))
}

def doMyStuff = {
  for {
    (div1, _) <- divide(10, 2)
    (_, rem2) <- divide(div1, 0)
    z <- divide(rem2, 8)
  } yield (div1, rem2, z)
}
```

Elixir equivalent:
``` elixir
defmodule Test do
  import Try
  import MonadicFor
  
  def division(x, y) do
    if y != 0, do: success({div(x, y), rem(x, y)}),
      else: failure("Cannot divide by zero!")
  end

  def do_my_stuff do
    ffor do
      {div1, _} <- division(10, 2)
      {_, rem2} <- division(div1, 0)
      z <- division(rem2, 8)
    after
      {div1, rem2, z}
    end
  end
end
```
