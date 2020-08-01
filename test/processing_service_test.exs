defmodule ProcessingServiceTest do
  use ExUnit.Case

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
end
