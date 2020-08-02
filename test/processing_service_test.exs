defmodule ProcessingServiceTest do
  use ExUnit.Case

  defmodule FakeProcessingContainer do
    defstruct []
  end

  defimpl Providers.ExternalDataProviderProtocol, for: FakeProcessingContainer do
    def get(_d, path) do
      Providers.ExternalDataProviderProtocol.impl_for!(%DependencyContainer{}).get(
        %DependencyContainer{},
        path
      )
    end
  end

  defimpl Repository.ExternalApiRepositoryProtocol, for: FakeProcessingContainer do
    def fetchPurchaseOrder(_) do
      Repository.ExternalApiRepositoryProtocol.impl_for!(%DependencyContainer{}).fetchPurchaseOrder(
        %DependencyContainer{}
      )
    end
  end

  defimpl Repository.OrdersApiProtocol, for: FakeProcessingContainer do
    def registerNewOrder(_, processedOrder) do
      if processedOrder.externalCode == nil do
        raise "force error"
      end

      :ok
    end
  end

  test "process order" do
    processedOrder =
      Repository.ExternalApiRepositoryProtocol.fetchPurchaseOrder(%DependencyContainer{})
      |> Services.ProcessingService.processOrder()

    assert processedOrder.storeId == 282
    assert processedOrder.externalCode == "9987071"
    assert processedOrder.customer.externalCode == "136226073"
    assert List.first(processedOrder.items).externalCode == "IT4801901403"
    assert List.first(processedOrder.payments).value == 55.04
  end

  test "process order with invalid fields" do
    order = Repository.ExternalApiRepositoryProtocol.fetchPurchaseOrder(%DependencyContainer{})

    assert_raise RuntimeError, fn ->
      %{order | id: nil} |> Services.ProcessingService.processOrder()
    end
  end

  test "send processed order to api w/ mocked api" do
    container = %FakeProcessingContainer{}

    returnValue =
      Repository.ExternalApiRepositoryProtocol.fetchPurchaseOrder(container)
      |> Services.ProcessingService.processOrder()
      |> Services.ProcessingService.saveProcessedOrder(container)

    assert returnValue == :ok
  end

  test "send processed order with invalid fields to api w/ mocked api" do
    container = %FakeProcessingContainer{}

    processedOrder =
      Repository.ExternalApiRepositoryProtocol.fetchPurchaseOrder(container)
      |> Services.ProcessingService.processOrder()

    assert_raise RuntimeError, fn ->
      %{processedOrder | externalCode: nil}
      |> Services.ProcessingService.saveProcessedOrder(container)
    end
  end
end
