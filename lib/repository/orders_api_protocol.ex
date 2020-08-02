defprotocol Repository.OrdersApiProtocol do
  @moduledoc """
  Repository interface to communicate with Orders API
  """
  @spec registerNewOrder(any, Models.ProcessedOrder) :: any
  @doc "register new order for some api"
  def registerNewOrder(container, processedOrder)
end
