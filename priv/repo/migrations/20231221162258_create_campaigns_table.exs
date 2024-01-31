defmodule DivulgaIo.Repo.Migrations.CreateCampaignsTable do
  use Ecto.Migration

  def change do
    create table(:campaigns) do
      add :slug, :text
      add :description, :text
      add :views_count, :integer
      add :is_active, :boolean
      add :business_id, references(:businesses, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:campaigns, :slug)
  end
end
