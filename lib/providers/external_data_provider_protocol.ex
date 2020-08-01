defprotocol Providers.ExternalDataProviderProtocol do
  @moduledoc """
  Base data provider protocol to communicate with external API's
  """

  @doc "get json data from an external API"
  def get(_c, path)
end
