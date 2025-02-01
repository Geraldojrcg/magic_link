defmodule MagicLink.BioLinksTest do
  use MagicLink.DataCase

  alias MagicLink.BioLinks

  describe "bio_links" do
    alias MagicLink.BioLinks.BioLink

    import MagicLink.BioLinksFixtures

    @invalid_attrs %{description: nil, title: nil, banner: nil}

    test "list_bio_links/0 returns all bio_links" do
      bio_link = bio_link_fixture()
      assert BioLinks.list_bio_links() == [bio_link]
    end

    test "get_bio_link!/1 returns the bio_link with given id" do
      bio_link = bio_link_fixture()
      assert BioLinks.get_bio_link!(bio_link.id) == bio_link
    end

    test "create_bio_link/1 with valid data creates a bio_link" do
      valid_attrs = %{description: "some description", title: "some title", banner: "some banner"}

      assert {:ok, %BioLink{} = bio_link} = BioLinks.create_bio_link(valid_attrs)
      assert bio_link.description == "some description"
      assert bio_link.title == "some title"
      assert bio_link.banner == "some banner"
    end

    test "create_bio_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BioLinks.create_bio_link(@invalid_attrs)
    end

    test "update_bio_link/2 with valid data updates the bio_link" do
      bio_link = bio_link_fixture()
      update_attrs = %{description: "some updated description", title: "some updated title", banner: "some updated banner"}

      assert {:ok, %BioLink{} = bio_link} = BioLinks.update_bio_link(bio_link, update_attrs)
      assert bio_link.description == "some updated description"
      assert bio_link.title == "some updated title"
      assert bio_link.banner == "some updated banner"
    end

    test "update_bio_link/2 with invalid data returns error changeset" do
      bio_link = bio_link_fixture()
      assert {:error, %Ecto.Changeset{}} = BioLinks.update_bio_link(bio_link, @invalid_attrs)
      assert bio_link == BioLinks.get_bio_link!(bio_link.id)
    end

    test "delete_bio_link/1 deletes the bio_link" do
      bio_link = bio_link_fixture()
      assert {:ok, %BioLink{}} = BioLinks.delete_bio_link(bio_link)
      assert_raise Ecto.NoResultsError, fn -> BioLinks.get_bio_link!(bio_link.id) end
    end

    test "change_bio_link/1 returns a bio_link changeset" do
      bio_link = bio_link_fixture()
      assert %Ecto.Changeset{} = BioLinks.change_bio_link(bio_link)
    end
  end
end
