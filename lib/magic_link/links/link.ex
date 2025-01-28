defmodule MagicLink.Links.Link do
  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :original_url, :string
    field :short_url, :string
    field :published_at, :utc_datetime
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:original_url, :short_url, :published_at])
    |> validate_required([:original_url, :short_url, :published_at])
    |> unique_constraint(:short_url)
  end
end
