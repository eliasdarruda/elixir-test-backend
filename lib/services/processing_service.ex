defmodule Services.ProcessingService do
  @spec processOrder(Models.Order) :: Models.ProcessedOrder
  @doc "process and validate order data"
  def processOrder(order) do
    %Models.ProcessedOrder{}
    |> parseEqualInfo(order)
    |> parseOrderTotal(order)
    |> parseCustomer(order)
    |> parseItems(order)
    |> parsePayments(order)
    |> validateParsingErrors()
  end

  @spec saveProcessOrder(Models.ProcessedOrder) :: nil
  def saveProcessOrder(processedOrder) do
    nil
  end

  defp validateParsingErrors(processed) do
    changeset = Models.ProcessedOrder.changeset(processed, %{})

    if !changeset.valid? do
      raise "Some of the payload fields are invalid -> " <> inspect(changeset.errors)
    end

    processed
  end

  @spec parseEqualInfo(Models.ProcessedOrder, Models.Order) :: Models.ProcessedOrder
  defp parseEqualInfo(processed, order) do
    Models.ProcessedOrder.cast(processed, %{
      externalCode: to_string(order.id),
      storeId: order.store_id,
      country: order.shipping.receiver_address.country.id,
      city: order.shipping.receiver_address.city.name,
      state: order.shipping.receiver_address.state.name,
      district: order.shipping.receiver_address.neighborhood.name,
      street: order.shipping.receiver_address.street_name,
      complement: order.shipping.receiver_address.comment,
      postalCode: order.shipping.receiver_address.zip_code,
      number: order.shipping.receiver_address.street_number,
      latitude: order.shipping.receiver_address.latitude,
      longitude: order.shipping.receiver_address.longitude,
      dtOrderCreate: order.shipping.date_created
    })
  end

  @spec parseOrderTotal(Models.ProcessedOrder, Models.Order) :: Models.ProcessedOrder
  defp parseOrderTotal(processed, order) do
    Models.ProcessedOrder.cast(processed, %{
      subTotal: order.total_amount,
      total: order.total_amount_with_shipping,
      deliveryFee: order.total_shipping
    })
  end

  @spec parseCustomer(Models.ProcessedOrder, Models.Order) :: Models.ProcessedOrder
  defp parseCustomer(processed, order) do
    Models.ProcessedOrder.cast(processed, %{
      customer: %{
        externalCode: to_string(order.buyer.id),
        name: "#{order.buyer.first_name} #{order.buyer.last_name}",
        email: order.buyer.email,
        contact: "#{order.buyer.phone.area_code}#{order.buyer.phone.number}"
      }
    })
  end

  @spec parseItems(Models.ProcessedOrder, Models.Order) :: Models.ProcessedOrder
  defp parseItems(processed, order) do
    items =
      Enum.map(
        order.order_items,
        fn orderItem ->
          %{
            externalCode: orderItem.item.id,
            name: orderItem.item.title,
            price: orderItem.unit_price,
            total: orderItem.full_unit_price,
            quantity: orderItem.quantity,
            subItems: []
          }
        end
      )

    Models.ProcessedOrder.cast(processed, %{
      items: items
    })
  end

  @spec parsePayments(Models.ProcessedOrder, Models.Order) :: Models.ProcessedOrder
  defp parsePayments(processed, order) do
    payments =
      Enum.map(
        order.payments,
        fn payment ->
          %{
            type: String.upcase(payment.payment_type),
            value: payment.total_paid_amount
          }
        end
      )

    Models.ProcessedOrder.cast(processed, %{
      payments: payments
    })
  end
end
