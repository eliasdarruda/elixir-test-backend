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
