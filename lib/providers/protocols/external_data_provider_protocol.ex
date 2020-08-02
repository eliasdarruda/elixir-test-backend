defprotocol Providers.ExternalDataProviderProtocol do
  @moduledoc """
  Base data provider protocol to communicate with external API's
  """

  @spec get(any, binary) :: term | no_return

  @doc "get json data from an external API"
  def get(_c, path)
end
