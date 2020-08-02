defmodule Models.ProcessedPayments do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:type, :string)
    field(:value, :float)
  end

  @required [
    :type,
    :value
  ]

  def changeset(schema, params) do
    schema
    |> cast(params, @required)
    |> validate_required(@required)
  end
end

defimpl Jason.Encoder, for: Models.ProcessedPayments do
  def encode(struct, opts) do
    Enum.reduce(Map.from_struct(struct), %{}, fn
      {k, %Ecto.Association.NotLoaded{}}, acc -> acc
      {k, v}, acc -> Map.put(acc, k, v)
    end)
    |> Jason.Encode.map(opts)
  end
end
