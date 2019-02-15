defmodule Try do

  defmodule Success do
    defstruct [:value]
  end

  defmodule Failure do
    defstruct [:error]
  end

  def success(x), do: %Success{value: x}
  def failure(e), do: %Failure{error: e}

  def result({:ok, v}), do: success(v)
  def result({:error, e}), do: failure(e)

  def is_try(%Success{}), do: true
  def is_try(%Failure{}), do: true
  def is_try(_), do: false
end

defimpl MonadLike, for: Try.Success do
  alias Try.Success, as: Success
  
  def map(%Success{value: x}, fun), do: %Success{value: fun.(x)}
  def fmap(%Success{value: x}, fun), do: fun.(x)
end


defimpl MonadLike, for: Try.Failure do
  alias Try.Failure, as: Failure
  
  def map(r = %Failure{}, _fun), do: r
  def fmap(r = %Failure{}, _fun), do: r
end
