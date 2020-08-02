defmodule Models.ProcessedOrder do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:externalCode, :string)
    field(:storeId, :integer)
    field(:subTotal, :float)
    field(:deliveryFee, :float)
    field(:total_shipping, :float)
    field(:total, :float)
    field(:country, :string)
    field(:state, :string)
    field(:city, :string)
    field(:district, :string)
    field(:street, :string)
    field(:complement, :string)
    field(:latitude, :float)
    field(:longitude, :float)
    field(:dtOrderCreate, :utc_datetime)
    field(:postalCode, :string)
    field(:number, :string)

    embeds_one(:customer, Models.ProcessedCustomer)
    embeds_many(:payments, Models.ProcessedPayments)
    embeds_many(:items, Models.ProcessedItems)
  end

  @fields [
    :externalCode,
    :storeId,
    :subTotal,
    :deliveryFee,
    :total_shipping,
    :total,
    :country,
    :state,
    :city,
    :district,
    :street,
    :complement,
    :latitude,
    :longitude,
    :dtOrderCreate,
    :postalCode,
    :number
  ]

  def changeset(schema, params) do
    schema
    |> cast(params, @fields)
    |> cast_embed(:customer)
    |> cast_embed(:items)
    |> cast_embed(:payments)
    |> validate_required(@fields ++ [:customer, :items, :payments])
  end

  def cast(schema, params) do
    schema
    |> cast(params, @fields)
    |> cast_embed(:customer)
    |> cast_embed(:items)
    |> cast_embed(:payments)
    |> apply_changes
  end

  def apply(schema) do
    schema |> apply_changes
  end
end

defimpl Jason.Encoder, for: Models.ProcessedOrder do
  def encode(struct, opts) do
    Enum.reduce(Map.from_struct(struct), %{}, fn
      {_, %Ecto.Association.NotLoaded{}}, acc -> acc
      {k, v}, acc -> Map.put(acc, k, v)
    end)
    |> Jason.Encode.map(opts)
  end
end
