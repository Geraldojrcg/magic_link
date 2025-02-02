defmodule MagicLink.ExternalLinks.ExternalLink do
  use Ecto.Schema
  import Ecto.Changeset

  alias MagicLink.BioLinks.BioLink

  schema "external_links" do
    field :title, :string
    field :url, :string

    belongs_to :bio_link, BioLink

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(external_link, attrs) do
    external_link
    |> cast(attrs, [:title, :url, :bio_link_id])
    |> validate_fields()
  end

  def changeset_assoc(external_link, attrs) do
    external_link
    |> cast(attrs, [:title, :url])
    |> validate_fields()
  end

  defp validate_fields(changeset) do
    changeset
    |> validate_required([:title, :url])
    |> validate_length(:title, min: 3, max: 100)
    |> validate_format(:url, ~r/^https?:\/\/.*$/, message: "must be a valid URL")
  end
end
