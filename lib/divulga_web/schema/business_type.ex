defmodule DivulgaWeb.Schema.Types.BusinessType do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  object :business_type do
    field(:id, :id)
    field(:city, :string)
    field(:country, :string)
    field(:county, :string)
    field(:description, :string)
    field(:email, :string)
    field(:instagram_url, :string)
    field(:logo, :string)
    field(:phone, :string)
    field(:title, :string)
    field(:views, :integer)
    field(:user, :user_type, resolve: dataloader(Divulga.Accounts))
  end

  input_object :business_input_type do
    field(:city, non_null(:string))
    field(:country, non_null(:string))
    field(:county, non_null(:string))
    field(:description, non_null(:string))
    field(:email, :string)
    field(:instagram_url, :string)
    field(:logo, :string)
    field(:phone, non_null(:string))
    field(:title, non_null(:string))
  end
end
