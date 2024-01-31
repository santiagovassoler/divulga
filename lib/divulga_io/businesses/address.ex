defmodule DivulgaIo.Businesses.Address do
  use Ecto.Schema
  import Ecto.Changeset

  schema "addresses" do
    field :first_line, :string
    field :second_line, :string
    field :city, :string
    field :postcode, :string
    field :country, :string
    belongs_to :business, DivulgaIo.Businesses.Business
  end

  @required_params [:first_line, :city, :postcode, :country, :business_id]
  @available_params [:second_line | @required_params]

  def create_changeset(params \\ %{}), do: changeset(%__MODULE__{}, params)
  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, @available_params)
    |> foreign_key_constraint(:business, name: :addresses_business_id_fkey)
    |> validate_required(@required_params)
    |> cast_assoc(:business)
  end
end
