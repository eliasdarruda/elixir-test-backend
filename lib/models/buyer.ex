defmodule Models.Buyer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :integer)
    field(:nickname, :string)
    field(:email, :string)
    field(:last_name, :string)
    field(:first_name, :string)
    embeds_one(:phone, Models.BuyerPhone)
    embeds_one(:billing_info, Models.BuyerBillingInfo)
  end

  @required [:id, :nickname, :email, :last_name, :first_name]

  def changeset(schema, params) do
    schema
    |> cast(params, @required)
    |> cast_embed(:phone)
    |> cast_embed(:billing_info)
  end

  def cast(params) do
    %Models.Buyer{}
    |> cast(params, @required)
    |> cast_embed(:phone)
    |> cast_embed(:billing_info)
    |> apply_changes
  end
end
