defmodule MagicLink.Repo.Migrations.CreateExternalLinks do
  use Ecto.Migration

  def change do
    create table(:external_links) do
      add :title, :string
      add :url, :string

      add :bio_link_id, references(:bio_links, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:external_links, [:bio_link_id])
  end
end
