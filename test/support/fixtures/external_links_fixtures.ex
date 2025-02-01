defmodule MagicLink.ExternalLinksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MagicLink.ExternalLinks` context.
  """

  @doc """
  Generate a external_link.
  """
  def external_link_fixture(attrs \\ %{}) do
    {:ok, external_link} =
      attrs
      |> Enum.into(%{
        url: "some url"
      })
      |> MagicLink.ExternalLinks.create_external_link()

    external_link
  end
end
