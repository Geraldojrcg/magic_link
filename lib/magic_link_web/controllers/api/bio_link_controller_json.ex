defmodule MagicLinkWeb.BioLinkControllerJSON do
  use MagicLinkWeb, :controller

  alias MagicLink.BioLinks
  alias MagicLink.BioLinks.BioLink

  action_fallback MagicLinkWeb.FallbackController

  def index(conn, _params) do
    bio_links = BioLinks.list_bio_links()
    render(conn, :index, bio_links: bio_links)
  end

  def create(conn, %{"bio_link" => bio_link_params}) do
    with {:ok, %BioLink{} = bio_link} <- BioLinks.create_bio_link(bio_link_params) do
      conn
      |> put_status(:created)
      |> render(:show, bio_link: bio_link)
    end
  end

  def show(conn, %{"id" => id}) do
    bio_link = BioLinks.get_bio_link!(id)
    render(conn, :show, bio_link: bio_link)
  end

  def update(conn, %{"id" => id, "bio_link" => bio_link_params}) do
    bio_link = BioLinks.get_bio_link!(id)

    with {:ok, %BioLink{} = bio_link} <- BioLinks.update_bio_link(bio_link, bio_link_params) do
      render(conn, :show, bio_link: bio_link)
    end
  end

  def delete(conn, %{"id" => id}) do
    bio_link = BioLinks.get_bio_link!(id)

    with {:ok, %BioLink{}} <- BioLinks.delete_bio_link(bio_link) do
      send_resp(conn, :no_content, "")
    end
  end
end
