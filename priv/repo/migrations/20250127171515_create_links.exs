defmodule MagicLink.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :original_url, :string
      add :short_url, :string
      add :published_at, :utc_datetime
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:links, [:short_url])
    create index(:links, [:user_id])
  end
end
