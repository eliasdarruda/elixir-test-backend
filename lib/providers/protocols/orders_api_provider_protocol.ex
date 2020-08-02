defprotocol Providers.OrdersApiProviderProtocol do
  @moduledoc """
  Base data provider protocol to communicate with Orders API
  """

  def post(_c, path, data)
end
