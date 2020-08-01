defmodule Models.BuyerBillingInfo do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:doc_type, :string)
    field(:doc_number, :string)
  end

  @required [:doc_number, :doc_type]

  def changeset(schema, params) do
    schema
    |> cast(params, @required)
  end
end
