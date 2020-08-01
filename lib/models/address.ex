import Ecto.Changeset

defmodule Models.Address do
  use Ecto.Schema

  @primary_key false
  embedded_schema do
    field(:id, :integer)
    field(:address_line, :string)
    field(:street_name, :string)
    field(:street_number, :string)
    field(:comment, :string)
    field(:zip_code, :string)
    field(:latitude, :float)
    field(:longitude, :float)
    field(:receiver_phone, :string)

    embeds_one(:country, Models.Address.Country)
    embeds_one(:city, Models.Address.City)
    embeds_one(:state, Models.Address.State)
    embeds_one(:neighborhood, Models.Address.Neighborhood)
  end

  @required [
    :id,
    :address_line,
    :street_name,
    :street_number,
    :comment,
    :zip_code,
    :latitude,
    :longitude,
    :receiver_phone
  ]

  def changeset(schema, params) do
    schema
    |> cast(params, @required)
    |> cast_embed(:country)
    |> cast_embed(:city)
    |> cast_embed(:state)
    |> cast_embed(:neighborhood)
  end
end

defmodule Models.Address.Country do
  use Ecto.Schema

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

defmodule Models.Address.City do
  use Ecto.Schema

  embedded_schema do
    field(:name, :string)
  end

  def changeset(schema, params) do
    schema
    |> cast(params, [:name])
  end
end

defmodule Models.Address.State do
  use Ecto.Schema

  embedded_schema do
    field(:name, :string)
  end

  def changeset(schema, params) do
    schema
    |> cast(params, [:name])
  end
end

defmodule Models.Address.Neighborhood do
  use Ecto.Schema

  @primary_key false
  embedded_schema do
    field(:id)
    field(:name, :string)
  end

  def changeset(schema, params) do
    schema
    |> cast(params, [:id, :name])
  end
end
