defmodule Models.ProcessedItems do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:externalCode, :string)
    field(:name, :string)
    field(:price, :float)
    field(:quantity, :integer)
    field(:total, :float)
    field(:subItems, {:array, :any})
  end

  @required [
    :externalCode,
    :name,
    :price,
    :quantity,
    :total,
    :subItems
  ]

  def changeset(schema, params) do
    schema
    |> cast(params, @required)
    |> validate_required(@required)
  end
end

defimpl Jason.Encoder, for: Models.ProcessedItems do
  def encode(struct, opts) do
    Enum.reduce(Map.from_struct(struct), %{}, fn
      {_, %Ecto.Association.NotLoaded{}}, acc -> acc
      {k, v}, acc -> Map.put(acc, k, v)
    end)
    |> Jason.Encode.map(opts)
  end
end
