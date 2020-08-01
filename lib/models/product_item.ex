defmodule Models.ProductItem do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :string)
    field(:title, :string)
  end

  def changeset(schema, params) do
    schema
    |> cast(params, [:id, :title])
  end
end
