defmodule DivulgaIo.Repo.Migrations.CreateAddressTable do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :first_line, :text
      add :second_line, :text
      add :city, :string
      add :postcode, :string
      add :country, :string

      add :business_id, references(:businesses, on_delete: :delete_all)
    end

    create index(:addresses, :business_id)
  end
end
