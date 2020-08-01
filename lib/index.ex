defmodule INDEX do
  def init(container \\ %DependencyContainer{}) do
    Repository.ExternalApiRepositoryProtocol.fetchPurchaseOrders(container)
  end
end
