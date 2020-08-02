defmodule OrderJob do
  def init(container \\ %DependencyContainer{}) do
    Repository.ExternalApiRepositoryProtocol.fetchPurchaseOrder(container)
    |> Services.ProcessingService.processOrder()
    |> Services.ProcessingService.saveProcessOrder(container)
  end
end
