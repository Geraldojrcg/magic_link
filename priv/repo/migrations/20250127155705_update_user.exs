defmodule MagicLink.Repo.Migrations.UpdateUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :name, :text
    end
  end
end
