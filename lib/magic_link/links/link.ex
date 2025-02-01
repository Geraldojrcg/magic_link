defmodule MagicLink.Links.Link do
  use Ecto.Schema
  import Ecto.Changeset

  alias MagicLink.Accounts.User

  schema "links" do
    field :original_url, :string
    field :short_id, :string
    field :short_url, :string
    field :visit_count, :integer

    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:original_url, :short_id, :short_url, :visit_count, :user_id])
    |> validate_required([:original_url, :short_id, :short_url, :user_id])
    |> unique_constraint(:short_id)
  end
end
