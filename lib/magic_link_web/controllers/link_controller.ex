defmodule MagicLinkWeb.LinkController do
  use MagicLinkWeb, :controller

  alias MagicLink.Links

  def index(conn, _params) do
    links = Links.list_links()

    conn
    |> assign_prop(:links, links)
    |> render_inertia("Links")
  end
end
