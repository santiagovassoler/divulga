defmodule Divulga.Repo.Migrations.CreateBusinesses do
  use Ecto.Migration

  def change do
    create table(:businesses) do
      add :logo, :string
      add :title, :string
      add :email, :string
      add :phone, :string
      add :city, :string
      add :county, :string
      add :country, :string
      add :instagram_url, :string
      add :views, :integer
      add :description, :text
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:businesses, [:user_id])
  end
end
