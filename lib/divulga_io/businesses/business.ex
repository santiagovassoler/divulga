defmodule DivulgaIo.Businesses.Business do
  use Ecto.Schema
  import Ecto.Changeset
  alias DivulgaIo.Accounts.User
  alias DivulgaIo.Businesses.{Address, Campaign}

  schema "businesses" do
    field :name, :string
    field :description, :string
    field :recommendations_count, :integer, default: 0

    belongs_to :user, User
    has_many :addresses, Address
    has_many :campaigns, Campaign, where: [is_active: true]

    timestamps()
  end

  @available_fields [:name, :description, :recommendations_count, :user_id]

  def create_changeset(params \\ %{}), do: changeset(%__MODULE__{}, params)
  @doc false
  def changeset(business, attrs) do
    business
    |> cast(attrs, @available_fields)
    |> foreign_key_constraint(:user, name: :businesses_user_id_fkey)
    |> validate_required(@available_fields)
    |> cast_assoc(:user)
    |> cast_assoc(:addresses)
    |> cast_assoc(:campaigns)
  end

  def filter_by(%{post_code: value} = params), do: Map.put(params, :addresses, %{post_code: value})
  def filter_by(params), do: params

  def total_campaigns_allowed(recommendations) when recommendations >= 1000, do: 5
  def total_campaigns_allowed(recommendations) when recommendations >= 500, do: 4
  def total_campaigns_allowed(recommendations) when recommendations >= 100, do: 3
  def total_campaigns_allowed(recommendations) when recommendations >= 50, do: 2
  def total_campaigns_allowed(_), do: 1
end
