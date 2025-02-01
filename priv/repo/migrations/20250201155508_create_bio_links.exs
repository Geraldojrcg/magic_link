defmodule MagicLink.Repo.Migrations.CreateBioLinks do
  use Ecto.Migration

  def change do
    create table(:bio_links) do
      add :title, :string
      add :description, :string
      add :banner, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:bio_links, [:user_id])
  end
end
