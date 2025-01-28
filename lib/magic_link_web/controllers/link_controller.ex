defmodule MagicLinkWeb.LinkController do
  use MagicLinkWeb, :controller

  alias MagicLinkWeb.LinkJSON
  alias MagicLink.Links

  def index(%Plug.Conn{assigns: %{current_user: current_user}} = conn, _params) do
    links = Links.list_links_by_user(current_user.id)

    conn
    |> assign_prop(:links, LinkJSON.index(%{links: links})[:data])
    |> render_inertia("Links")
  end

  def create(%Plug.Conn{assigns: %{current_user: current_user}} = conn, params) do
    case Links.create_link(Map.put(params, "user_id", current_user.id)) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Link created successfully.")
        |> redirect(to: ~p"/links")

      {:error, changeset} ->
        conn
        |> assign_errors(changeset)
        |> redirect(to: ~p"/links")
    end
  end
end
