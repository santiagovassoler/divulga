defmodule DivulgaIoWeb.Types.Address do
  use Absinthe.Schema.Notation

  object :address do
    field :id, :id
    field :first_line, :string
    field :second_line, :string
    field :city, :string
    field :postcode, :string
    field :country, :string
  end

end
