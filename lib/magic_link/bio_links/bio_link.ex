defmodule MagicLink.BioLinks.BioLink do
  use Ecto.Schema
  import Ecto.Changeset

  alias MagicLink.Accounts.User
  alias MagicLink.Links.Link
  alias MagicLink.ExternalLinks.ExternalLink

  schema "bio_links" do
    field :title, :string
    field :description, :string
    field :banner, :string

    belongs_to :user, User
    belongs_to :link, Link
    has_many :external_links, ExternalLink, on_replace: :delete

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(bio_link, attrs) do
    bio_link
    |> cast(attrs, [:title, :description, :banner, :user_id, :link_id])
    |> validate_required([:title, :user_id, :link_id])
    |> validate_length(:title, min: 3, max: 100)
    |> validate_length(:description, min: 3, max: 200)
    |> validate_format(:banner, ~r/^https?:\/\/.*$/, message: "must be a valid URL")
    |> cast_assoc(:external_links, with: &ExternalLink.changeset_assoc/2)
  end
end
