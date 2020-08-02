defimpl Repository.OrdersApiProtocol, for: DependencyContainer do
  @spec registerNewOrder(any, Models.ProcessedOrder) :: any
  def registerNewOrder(container, processedOrder) do
    Providers.OrdersApiProviderProtocol.post(container, "/", processedOrder)
  end
end
