defimpl Repository.ExternalApiRepositoryProtocol, for: DependencyContainer do
  @spec fetchPurchaseOrder(any) :: Models.Order
  def fetchPurchaseOrder(container) do
    Providers.ExternalDataProviderProtocol.get(container, "payload")
    |> Models.Order.cast()
  end
end
