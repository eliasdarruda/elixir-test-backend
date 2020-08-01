defmodule OrderJob do
  @spec init(any) :: Order
  def init(container \\ %DependencyContainer{}) do
    Repository.ExternalApiRepositoryProtocol.fetchPurchaseOrder(container)
  end
end
