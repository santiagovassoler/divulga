defmodule DivulgaIo.Accounts.User do
  use Ecto.Schema
  alias DivulgaIo.Businesses.Business
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :email, :string
    has_many :business, Business

    timestamps()
  end

  @available_fields [:name, :email]

  def create_changeset(params \\ %{}), do: changeset(%__MODULE__{}, params)

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @available_fields)
    |> validate_required(@available_fields)
    |> unique_constraint(:email, message: "This email is already in use")
    |> cast_assoc(:business)
  end
end
