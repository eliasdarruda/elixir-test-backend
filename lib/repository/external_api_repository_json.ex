defimpl Repository.ExternalApiRepositoryProtocol, for: DependencyContainer do
  @spec fetchPurchaseOrder(any) :: Order
  def fetchPurchaseOrder(container) do
    Providers.ExternalDataProviderProtocol.get(container, "payload")
  end
end
