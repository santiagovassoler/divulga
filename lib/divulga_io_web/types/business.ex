defmodule DivulgaIoWeb.Types.Business do
  use Absinthe.Schema.Notation
  alias DivulgaIo.Businesses
  alias DivulgaIo.Accounts

  import Absinthe.Resolution.Helpers, only: [dataloader: 2]

  object :business do
    field :id, :id
    field :name, :string
    field :description, :string
    field :recommendations_count, :integer
    field :user, :user, resolve: dataloader(Accounts, :user)
    field :addresses, list_of(:address), resolve: dataloader(Businesses, :addresses)
    field :campaigns, list_of(:campaign), resolve: dataloader(Businesses, :campaigns)
  end

end
