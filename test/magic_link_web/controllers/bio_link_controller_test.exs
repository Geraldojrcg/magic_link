defmodule MagicLinkWeb.BioLinkControllerTest do
  use MagicLinkWeb.ConnCase

  import MagicLink.BioLinksFixtures

  alias MagicLink.BioLinks.BioLink

  @create_attrs %{
    description: "some description",
    title: "some title",
    banner: "some banner"
  }
  @update_attrs %{
    description: "some updated description",
    title: "some updated title",
    banner: "some updated banner"
  }
  @invalid_attrs %{description: nil, title: nil, banner: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all bio_links", %{conn: conn} do
      conn = get(conn, ~p"/api/bio_links")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create bio_link" do
    test "renders bio_link when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/bio_links", bio_link: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/bio_links/#{id}")

      assert %{
               "id" => ^id,
               "banner" => "some banner",
               "description" => "some description",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/bio_links", bio_link: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update bio_link" do
    setup [:create_bio_link]

    test "renders bio_link when data is valid", %{conn: conn, bio_link: %BioLink{id: id} = bio_link} do
      conn = put(conn, ~p"/api/bio_links/#{bio_link}", bio_link: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/bio_links/#{id}")

      assert %{
               "id" => ^id,
               "banner" => "some updated banner",
               "description" => "some updated description",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, bio_link: bio_link} do
      conn = put(conn, ~p"/api/bio_links/#{bio_link}", bio_link: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete bio_link" do
    setup [:create_bio_link]

    test "deletes chosen bio_link", %{conn: conn, bio_link: bio_link} do
      conn = delete(conn, ~p"/api/bio_links/#{bio_link}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/bio_links/#{bio_link}")
      end
    end
  end

  defp create_bio_link(_) do
    bio_link = bio_link_fixture()
    %{bio_link: bio_link}
  end
end
