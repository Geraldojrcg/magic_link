defmodule MagicLinkWeb.LinkController do
  use MagicLinkWeb, :controller

  alias MagicLinkWeb.BioLinkJSON
  alias MagicLinkWeb.LinkJSON

  alias MagicLink.Links
  alias MagicLink.BioLinks

  def index(%Plug.Conn{assigns: %{current_user: current_user}} = conn, _params) do
    links = Links.list_links_by_user(current_user.id)

    conn
    |> assign_prop(:links, LinkJSON.index(%{links: links})[:data])
    |> assign_prop(
      :bio_links,
      fn ->
        BioLinkJSON.index(%{bio_links: BioLinks.list_bio_links_by_user(current_user.id)}).data
      end
    )
    |> render_inertia("Links")
  end

  def create_link(%Plug.Conn{assigns: %{current_user: current_user}} = conn, params) do
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

  def delete_link(conn, %{"id" => id}) do
    case Links.delete_link_by_id(id) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Link deleted successfully.")
        |> redirect(to: ~p"/links")

      {:error, _} ->
        conn
        |> put_flash(:error, "Link not found.")
        |> redirect(to: ~p"/links")
    end
  end

  def create_bio_link(%Plug.Conn{assigns: %{current_user: current_user}} = conn, params) do
    case BioLinks.create_bio_link(Map.put(params, "user_id", current_user.id)) do
      {:ok, bio} ->
        IO.inspect(bio)

        conn
        |> put_flash(:info, "Bio link created successfully.")
        |> redirect(to: ~p"/links")

      {:error, changeset} ->
        conn
        |> assign_errors(changeset)
        |> redirect(to: ~p"/links")
    end
  end

  def update_bio_link(conn, %{"id" => id} = params) do
    bio_link = BioLinks.get_bio_link!(id)

    IO.inspect(bio_link)

    case BioLinks.update_bio_link(bio_link, params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Bio link updated successfully.")
        |> redirect(to: ~p"/links")

      {:error, changeset} ->
        conn
        |> assign_errors(changeset)
        |> redirect(to: ~p"/links")
    end
  end

  def delete_bio_link(conn, %{"id" => id}) do
    case BioLinks.delete_bio_link_by_id(id) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Bio link deleted successfully.")
        |> redirect(to: ~p"/links")

      {:error, _} ->
        conn
        |> put_flash(:error, "Bio link not found.")
        |> redirect(to: ~p"/links")
    end
  end
end
