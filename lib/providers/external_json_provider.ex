defimpl Providers.ExternalDataProviderProtocol, for: DependencyContainer do
  @base_url "./external/"

  @spec get(any, binary) :: term | no_return
  def get(_c, path) do
    file_dir = @base_url <> path <> ".json"
    {:ok, content} = file_dir |> Path.expand() |> File.read()
    Jason.decode!(content)
  end
end
