defimpl Repository.OrdersApiProtocol, for: DependencyContainer do
  def registerNewOrder(container, processedOrder) do
    Providers.OrdersApiProviderProtocol.post(container, "/", processedOrder)
  end
end
