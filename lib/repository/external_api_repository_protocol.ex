defprotocol Repository.ExternalApiRepositoryProtocol do
  @moduledoc """
  Repository interface to communicate with external API
  """
  @spec fetchPurchaseOrder(any) :: Models.Order
  @doc "get purchase order from external api provider"
  def fetchPurchaseOrder(container)
end
