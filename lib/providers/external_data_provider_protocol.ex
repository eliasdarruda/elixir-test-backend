defprotocol Providers.ExternalDataProviderProtocol do
  @moduledoc """
  Base data provider protocol to communicate with external API's
  """

  @spec get(any, any) :: any

  @doc "get json data from an external API"
  def get(_c, path)
end
