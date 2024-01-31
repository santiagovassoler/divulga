defmodule DivulgaIo.Businesses.Campaign do
  use Ecto.Schema
  import Ecto.Changeset
  alias DivulgaIo.Businesses.Business

  schema "campaigns" do
    field :slug, :string
    field :description, :string
    field :views_count, :integer, default: 0
    field :is_active, :boolean, default: true
    belongs_to :business, Business

    timestamps()
  end

  @available_fields [:slug, :description, :views_count, :is_active, :business_id]

  @doc false
  def changeset(campaigns, attrs) do
    campaigns
    |> cast(attrs, @available_fields)
    |> foreign_key_constraint(:business, name: :campaigns_business_id_fkey)
    |> validate_required(@available_fields)
    |> unique_constraint(:slug, message: "This slug is already in use")
    |> cast_assoc(:business)
  end
end
