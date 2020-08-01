defmodule Models.Shipping do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :integer)
    field(:shipment_type, :string)
    field(:date_created, :string)
    embeds_one(:receiver_address, Models.Address)
  end

  def changeset(schema, params) do
    schema
    |> cast(params, [:id, :shipment_type, :date_created])
    |> cast_embed(:receiver_address)
  end
end
