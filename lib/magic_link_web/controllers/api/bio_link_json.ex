defmodule MagicLinkWeb.BioLinkJSON do
  alias MagicLinkWeb.ExternalLinkJSON
  alias MagicLink.BioLinks.BioLink

  @doc """
  Renders a list of bio_links.
  """
  def index(%{bio_links: bio_links}) do
    %{data: for(bio_link <- bio_links, do: data(bio_link))}
  end

  @doc """
  Renders a single bio_link.
  """
  def show(%{bio_link: bio_link}) do
    %{data: data(bio_link)}
  end

  defp data(%BioLink{} = bio_link) do
    %{
      id: bio_link.id,
      title: bio_link.title,
      description: bio_link.description,
      banner: bio_link.banner,
      external_links: ExternalLinkJSON.index(%{external_links: bio_link.external_links}).data
    }
  end
end
