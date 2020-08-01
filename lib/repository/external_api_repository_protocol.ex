defprotocol Repository.ExternalApiRepositoryProtocol do
  @moduledoc """
  Repository interface to communicate with external API
  """
  @doc "get purchase order from external api provider"
  def fetchPurchaseOrders(container)
end
