defmodule Models.AddressCountry do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :string)
    field(:name, :string)
  end

  def changeset(schema, params) do
    schema
    |> cast(params, [:id, :name])
  end
end
