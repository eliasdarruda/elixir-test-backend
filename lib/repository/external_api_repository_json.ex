defimpl Repository.ExternalApiRepositoryProtocol, for: DependencyContainer do
  def fetchPurchaseOrders(container) do
    Providers.ExternalDataProviderProtocol.get(container, "payload")
  end
end
