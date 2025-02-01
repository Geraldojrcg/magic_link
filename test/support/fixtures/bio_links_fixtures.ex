defmodule MagicLink.BioLinksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MagicLink.BioLinks` context.
  """

  @doc """
  Generate a bio_link.
  """
  def bio_link_fixture(attrs \\ %{}) do
    {:ok, bio_link} =
      attrs
      |> Enum.into(%{
        banner: "some banner",
        description: "some description",
        title: "some title"
      })
      |> MagicLink.BioLinks.create_bio_link()

    bio_link
  end
end
