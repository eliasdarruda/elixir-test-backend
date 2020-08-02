defimpl Repository.ExternalApiRepositoryProtocol, for: DependencyContainer do
  def fetchPurchaseOrder(container) do
    Providers.ExternalDataProviderProtocol.get(container, "payload")
    |> Models.Order.cast()
  end
end
