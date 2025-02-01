defmodule MagicLinkWeb.ExternalLinkControllerJSON do
  use MagicLinkWeb, :controller

  alias MagicLink.ExternalLinks
  alias MagicLink.ExternalLinks.ExternalLink

  action_fallback MagicLinkWeb.FallbackController

  def index(conn, _params) do
    external_links = ExternalLinks.list_external_links()
    render(conn, :index, external_links: external_links)
  end

  def create(conn, %{"external_link" => external_link_params}) do
    with {:ok, %ExternalLink{} = external_link} <-
           ExternalLinks.create_external_link(external_link_params) do
      conn
      |> put_status(:created)
      |> render(:show, external_link: external_link)
    end
  end

  def show(conn, %{"id" => id}) do
    external_link = ExternalLinks.get_external_link!(id)
    render(conn, :show, external_link: external_link)
  end

  def update(conn, %{"id" => id, "external_link" => external_link_params}) do
    external_link = ExternalLinks.get_external_link!(id)

    with {:ok, %ExternalLink{} = external_link} <-
           ExternalLinks.update_external_link(external_link, external_link_params) do
      render(conn, :show, external_link: external_link)
    end
  end

  def delete(conn, %{"id" => id}) do
    external_link = ExternalLinks.get_external_link!(id)

    with {:ok, %ExternalLink{}} <- ExternalLinks.delete_external_link(external_link) do
      send_resp(conn, :no_content, "")
    end
  end
end
