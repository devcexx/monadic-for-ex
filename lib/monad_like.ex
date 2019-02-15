defprotocol MonadLike do
  def map(o, fun)
  def fmap(o, fun)
end
