defmodule Models.OrderItem do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    embeds_one(:item, Models.ProductItem)
    field(:quantity, :integer)
    field(:unit_price, :float)
    field(:full_unit_price, :float)
  end

  def changeset(schema, params) do
    schema
    |> cast(params, [:quantity, :unit_price, :full_unit_price])
    |> cast_embed(:item)
  end
end
