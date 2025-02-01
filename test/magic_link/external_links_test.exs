defmodule MagicLink.ExternalLinksTest do
  use MagicLink.DataCase

  alias MagicLink.ExternalLinks

  describe "external_links" do
    alias MagicLink.ExternalLinks.ExternalLink

    import MagicLink.ExternalLinksFixtures

    @invalid_attrs %{url: nil}

    test "list_external_links/0 returns all external_links" do
      external_link = external_link_fixture()
      assert ExternalLinks.list_external_links() == [external_link]
    end

    test "get_external_link!/1 returns the external_link with given id" do
      external_link = external_link_fixture()
      assert ExternalLinks.get_external_link!(external_link.id) == external_link
    end

    test "create_external_link/1 with valid data creates a external_link" do
      valid_attrs = %{url: "some url"}

      assert {:ok, %ExternalLink{} = external_link} = ExternalLinks.create_external_link(valid_attrs)
      assert external_link.url == "some url"
    end

    test "create_external_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ExternalLinks.create_external_link(@invalid_attrs)
    end

    test "update_external_link/2 with valid data updates the external_link" do
      external_link = external_link_fixture()
      update_attrs = %{url: "some updated url"}

      assert {:ok, %ExternalLink{} = external_link} = ExternalLinks.update_external_link(external_link, update_attrs)
      assert external_link.url == "some updated url"
    end

    test "update_external_link/2 with invalid data returns error changeset" do
      external_link = external_link_fixture()
      assert {:error, %Ecto.Changeset{}} = ExternalLinks.update_external_link(external_link, @invalid_attrs)
      assert external_link == ExternalLinks.get_external_link!(external_link.id)
    end

    test "delete_external_link/1 deletes the external_link" do
      external_link = external_link_fixture()
      assert {:ok, %ExternalLink{}} = ExternalLinks.delete_external_link(external_link)
      assert_raise Ecto.NoResultsError, fn -> ExternalLinks.get_external_link!(external_link.id) end
    end

    test "change_external_link/1 returns a external_link changeset" do
      external_link = external_link_fixture()
      assert %Ecto.Changeset{} = ExternalLinks.change_external_link(external_link)
    end
  end
end
