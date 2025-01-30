defmodule MagicLinkWeb.LinkResolverController do
  use MagicLinkWeb, :controller

  alias MagicLink.Links

  def show(conn, %{"short_id" => short_id}) do
    case Links.get_link_by_short_id!(short_id) do
      {:ok, link} ->
        conn
        |> redirect(external: link.original_url)

      {:error, _} ->
        conn
        |> send_resp(404, "")
    end
  end
end
