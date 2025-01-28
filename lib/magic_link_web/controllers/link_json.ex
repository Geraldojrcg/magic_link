defmodule MagicLinkWeb.LinkJSON do
  alias MagicLink.Links.Link

  @doc """
  Renders a list of links.
  """
  def index(%{links: links}) do
    %{data: for(link <- links, do: data(link))}
  end

  @doc """
  Renders a single link.
  """
  def show(%{link: link}) do
    %{data: data(link)}
  end

  defp data(%Link{} = link) do
    %{
      id: link.id,
      original_url: link.original_url,
      short_url: link.short_url,
      visit_count: link.visit_count
    }
  end
end
