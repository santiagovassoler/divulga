defmodule Divulga.Advert.Business do
  use Ecto.Schema
  import Ecto.Changeset
  alias Divulga.Accounts.User

  schema "businesses" do
    field :city, :string
    field :country, :string
    field :county, :string
    field :description, :string
    field :email, :string
    field :instagram_url, :string
    field :logo, :string
    field :phone, :string
    field :title, :string
    field :views, :integer
    belongs_to(:user, User)
    
    timestamps()
  end

  @doc false
  def changeset(business, attrs) do
    business
    |> cast(attrs, [:logo, :title, :email, :phone, :city, :county, :country, :instagram_url, :views, :description, :user_id])
    |> validate_required([:logo, :title, :email, :phone, :city, :county, :country, :instagram_url, :views, :description, :user_id])
  end
end
