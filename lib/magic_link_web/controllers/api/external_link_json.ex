defmodule MagicLinkWeb.ExternalLinkJSON do
  alias MagicLink.ExternalLinks.ExternalLink

  @doc """
  Renders a list of external_links.
  """
  def index(%{external_links: external_links}) do
    %{data: for(external_link <- external_links, do: data(external_link))}
  end

  @doc """
  Renders a single external_link.
  """
  def show(%{external_link: external_link}) do
    %{data: data(external_link)}
  end

  defp data(%ExternalLink{} = external_link) do
    %{
      id: external_link.id,
      title: external_link.title,
      url: external_link.url
    }
  end
end
