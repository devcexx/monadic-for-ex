defmodule Maybe do
  defmodule Just do
    defstruct [:value]
  end

  defmodule Nothing do
    defstruct []
  end

  def nothing, do: %Nothing{}
  def just(x), do: %Just{value: x}

  def maybe(nil), do: nothing()
  def maybe(x), do: just(x)
  
  def is_maybe(%Just{}), do: true
  def is_maybe(%Nothing{}), do: true
  def is_maybe(_), do: false
end


defimpl MonadLike, for: Maybe.Just do
  alias Maybe.Just, as: Just
  
  def map(%Just{value: x}, fun), do: %Just{value: fun.(x)}
  def fmap(%Just{value: x}, fun), do: fun.(x)
end

defimpl MonadLike, for: Maybe.Nothing do
  alias Maybe.Nothing, as: Nothing
  
  def map(x = %Nothing{}, _fun), do: x
  def fmap(x = %Nothing{}, _fun), do: x
end
