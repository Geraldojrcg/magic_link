defmodule MagicLink.LinksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MagicLink.Links` context.
  """

  @doc """
  Generate a unique link short_url.
  """
  def unique_link_short_url, do: "some short_url#{System.unique_integer([:positive])}"

  @doc """
  Generate a link.
  """
  def link_fixture(attrs \\ %{}) do
    {:ok, link} =
      attrs
      |> Enum.into(%{
        original_url: "some original_url",
        published_at: ~U[2025-01-26 17:15:00Z],
        short_url: unique_link_short_url()
      })
      |> MagicLink.Links.create_link()

    link
  end
end
