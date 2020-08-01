defmodule RepositoryTest do
  use ExUnit.Case

  test "get mapped nested objects from external json" do
    order = Repository.ExternalApiRepositoryProtocol.fetchPurchaseOrder(%DependencyContainer{})
    [first_order_item | _] = order.order_items

    assert order.id == 9_987_071
    assert first_order_item.quantity == 1
    assert order.buyer.id == 136_226_073
  end
end
