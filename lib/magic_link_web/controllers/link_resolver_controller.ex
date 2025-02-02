defmodule MagicLinkWeb.LinkResolverController do
  use MagicLinkWeb, :controller

  alias MagicLink.Links
  alias MagicLink.BioLinks
  alias MagicLinkWeb.BioLinkJSON

  def show(conn, %{"short_id" => short_id}) do
    case Links.get_link_by_short_id!(short_id) do
      {:ok, link} when link.original_url != nil ->
        conn
        |> redirect(external: link.original_url)

      {:ok, link} when link.original_url == nil ->
        bio_link = BioLinks.get_bio_link_by_link_id!(link.id)

        conn
        |> assign_prop(:bio_link, BioLinkJSON.show(%{bio_link: bio_link})[:data])
        |> render_inertia("Bio")

      {:error, _} ->
        conn
        |> send_resp(404, "")
    end
  end
end
