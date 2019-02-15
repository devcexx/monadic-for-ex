# MonadicFor

Scala-style monadic for...yield structure for Elixir.

Scala:
``` scala
def safeDivision(x: Int, y: Int): Try[Int] = {
  if (y != 0) Success(x / y)
  else Failure(new ArithmeticException("Cannot divide by zero!"))
}

def doMyStuff = {
  for {
    x <- safeDivision(10, 2)
    y <- safeDivision(x, 0)
    z <- safeDivision(y, 8)
  } yield x + y + z
}
```

Elixir equivalent:
``` elixir
defmodule Test do
  import Try
  import MonadicFor
  
  def safe_division(x, y) do
    if y != 0, do: success(x / y),
      else: failure("Cannot divide by zero!")
  end

  def do_my_stuff do
    ffor do
      x <- safe_division(10, 2)
      y <- safe_division(x, 0)
      z <- safe_division(y, 8)
    after
      x + y + z
    end
  end
end
```
