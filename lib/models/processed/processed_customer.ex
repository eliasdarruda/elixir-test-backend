defmodule Models.ProcessedCustomer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:externalCode, :string)
    field(:name, :string)
    field(:email, :string)
    field(:contact, :string)
  end

  @required [
    :externalCode,
    :name,
    :email,
    :contact
  ]

  def changeset(schema, params) do
    schema
    |> cast(params, @required)
    |> validate_required(@required)
  end
end
