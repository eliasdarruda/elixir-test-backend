defmodule Models.BuyerPhone do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:area_code, :integer)
    field(:number, :string)
  end

  @required [:area_code, :number]

  def changeset(schema, params) do
    schema
    |> cast(params, @required)
  end
end
