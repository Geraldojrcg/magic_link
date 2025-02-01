defmodule MagicLink.BioLinks.BioLink do
  use Ecto.Schema
  import Ecto.Changeset

  alias MagicLink.Accounts.User
  alias MagicLink.ExternalLinks.ExternalLink

  schema "bio_links" do
    field :description, :string
    field :title, :string
    field :banner, :string

    belongs_to :user, User
    has_many :external_links, ExternalLink

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(bio_link, attrs) do
    bio_link
    |> cast(attrs, [:title, :description, :banner, :user_id])
    |> validate_required([:title, :user_id])
    |> validate_length(:title, min: 3, max: 100)
    |> validate_length(:description, min: 3, max: 200)
    |> validate_format(:banner, ~r/^(http|https):\/\/.*\.(png|jpg|jpeg)$/)
    |> put_assoc(:external_links, attrs.external_links || bio_link.external_links)
  end
end
