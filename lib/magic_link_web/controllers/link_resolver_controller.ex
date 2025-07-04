defmodule MagicLinkWeb.LinkResolverController do
  use MagicLinkWeb, :controller

  require Logger
  alias MagicLink.Links
  alias MagicLink.BioLinks
  alias MagicLinkWeb.BioLinkJSON

  def show(conn, %{"short_id" => short_id}) do
    case Links.get_link_by_short_id!(short_id) do
      {:ok, link} when link.original_url != nil ->
        send_link_accessed_event(link)

        conn
        |> redirect(external: link.original_url)

      {:ok, link} when link.original_url == nil ->
        bio_link = BioLinks.get_bio_link_by_link_id!(link.id)

        send_link_accessed_event(link)

        conn
        |> assign_prop(:bio_link, BioLinkJSON.show(%{bio_link: bio_link})[:data])
        |> render_inertia("Bio")

      {:error, _} ->
        conn
        |> send_resp(404, "")
    end
  end

  defp send_link_accessed_event(link) do
    MagicLinkWeb.Endpoint.broadcast("dashboard:lobby", "link_accessed", %{
      id: link.id,
      visit_count: link.visit_count
    })
  end
end
