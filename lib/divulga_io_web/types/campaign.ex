defmodule DivulgaIoWeb.Types.Campaign do
  use Absinthe.Schema.Notation

  object :campaign do
    field :id, :id
    field :slug, :string
    field :description, :string
    field :views_count, :integer
  end

end
