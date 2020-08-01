defmodule FakeContainer do
  defstruct []
end

defimpl Providers.ExternalDataProviderProtocol, for: FakeContainer do
  def get(_d, path) do
    path
  end
end

defimpl Repository.ExternalApiRepositoryProtocol, for: FakeContainer do
  def fetchPurchaseOrders(container) do
    path_return = Providers.ExternalDataProviderProtocol.get(container, "fakePath")
    %{id: "fakeId", path: path_return}
  end
end

defmodule DependencyTest do
  use ExUnit.Case

  test "gets mock data from fake external API repository and provider" do
    json = INDEX.init(%FakeContainer{})

    assert Map.get(json, :id) == "fakeId"
    assert Map.get(json, :path) == "fakePath"
  end
end
