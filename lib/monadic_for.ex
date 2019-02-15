defmodule MonadicFor do
  def expand_assign({:<-, _, [ var_quoted = {var_name, _, nil}, rhs]}, aft_block) when is_atom(var_name) do
    quote do
      MonadLike.map(unquote(rhs), fn unquote(var_quoted) -> unquote(aft_block) end)
    end
  end

  
  def expand_for_block([ hd | [] ], aft_block) do
    expand_assign(hd, aft_block)
  end

  def expand_for_block([ {:<-, _, [ var_quoted = {var_name, _, nil}, rhs]} | tl ], aft_block) when is_atom(var_name) do
    quote do
      MonadLike.fmap(unquote(rhs), fn unquote(var_quoted) -> unquote(expand_for_block(tl, aft_block)) end)
    end
  end
  
  defmacro ffor(do: do_block, after: aft_block) do
    case do_block do
      {:__block__, [], assignations} -> expand_for_block(assignations, aft_block)
      _ -> expand_assign(do_block, aft_block)
    end
  end
end
