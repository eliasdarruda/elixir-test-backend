defimpl Repository.ExternalApiRepositoryProtocol, for: DependencyContainer do
  def fetchPurchaseOrder(container) do
    Providers.ExternalDataProviderProtocol.get(container, "payload")
    # |> saveRequestedOrder()
    |> Models.Order.cast()
  end

  defp saveRequestedOrder(requestedOrders) do
    Application.ensure_all_started(:mongodb)

    {:ok, conn} = Mongo.start_link(database: "external_orders", auth_mechanism: :x509)
    Mongo.insert_one(conn, "orders", requestedOrders)

    requestedOrders
  end
end
