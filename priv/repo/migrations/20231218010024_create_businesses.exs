defmodule DivulgaIo.Repo.Migrations.CreateBusinesses do
  use Ecto.Migration

  def change do
    create table(:businesses) do
      add :name, :string
      add :description, :text
      add :recommendations_count, :integer
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:businesses, [:user_id])
  end
end
