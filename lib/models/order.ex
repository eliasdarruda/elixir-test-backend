defmodule Models.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :integer)
    field(:store_id, :integer)
    field(:date_created, :string)
    field(:date_closed, :string)
    field(:last_updated, :float)
    field(:total_amount, :float)
    field(:total_shipping, :float)
    field(:total_amount_with_shipping, :float)
    field(:paid_amount, :float)
    field(:expiration_date, :string)
    field(:status, :string)

    embeds_one(:shipping, Models.Shipping)
    embeds_one(:buyer, Models.Buyer)
    embeds_many(:payments, Models.Payment)
    embeds_many(:order_items, Models.OrderItem)
  end

  @required [
    :id,
    :store_id,
    :date_created,
    :date_closed,
    :last_updated,
    :total_amount,
    :total_shipping,
    :total_amount_with_shipping,
    :paid_amount,
    :expiration_date,
    :status
  ]

  def changeset(schema, params) do
    schema
    |> cast(params, @required)
    |> cast_embed(:shipping)
    |> cast_embed(:buyer)
    |> cast_embed(:payments)
    |> cast_embed(:order_items)
  end

  def cast(params) do
    %Models.Order{}
    |> cast(params, @required)
    |> cast_embed(:shipping)
    |> cast_embed(:buyer)
    |> cast_embed(:payments)
    |> cast_embed(:order_items)
    |> apply_changes
  end
end
