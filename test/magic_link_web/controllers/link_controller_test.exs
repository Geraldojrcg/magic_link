defmodule MagicLinkWeb.LinkControllerTest do
  use MagicLinkWeb.ConnCase

  import MagicLink.LinksFixtures

  alias MagicLink.Links.Link

  @create_attrs %{
    original_url: "some original_url",
    short_url: "some short_url",
    published_at: ~U[2025-01-26 17:15:00Z]
  }
  @update_attrs %{
    original_url: "some updated original_url",
    short_url: "some updated short_url",
    published_at: ~U[2025-01-27 17:15:00Z]
  }
  @invalid_attrs %{original_url: nil, short_url: nil, published_at: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all links", %{conn: conn} do
      conn = get(conn, ~p"/api/links")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create link" do
    test "renders link when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/links", link: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/links/#{id}")

      assert %{
               "id" => ^id,
               "original_url" => "some original_url",
               "published_at" => "2025-01-26T17:15:00Z",
               "short_url" => "some short_url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/links", link: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update link" do
    setup [:create_link]

    test "renders link when data is valid", %{conn: conn, link: %Link{id: id} = link} do
      conn = put(conn, ~p"/api/links/#{link}", link: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/links/#{id}")

      assert %{
               "id" => ^id,
               "original_url" => "some updated original_url",
               "published_at" => "2025-01-27T17:15:00Z",
               "short_url" => "some updated short_url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, link: link} do
      conn = put(conn, ~p"/api/links/#{link}", link: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete link" do
    setup [:create_link]

    test "deletes chosen link", %{conn: conn, link: link} do
      conn = delete(conn, ~p"/api/links/#{link}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/links/#{link}")
      end
    end
  end

  defp create_link(_) do
    link = link_fixture()
    %{link: link}
  end
end
