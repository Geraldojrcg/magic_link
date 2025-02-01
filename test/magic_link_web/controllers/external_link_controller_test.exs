defmodule MagicLinkWeb.ExternalLinkControllerTest do
  use MagicLinkWeb.ConnCase

  import MagicLink.ExternalLinksFixtures

  alias MagicLink.ExternalLinks.ExternalLink

  @create_attrs %{
    url: "some url"
  }
  @update_attrs %{
    url: "some updated url"
  }
  @invalid_attrs %{url: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all external_links", %{conn: conn} do
      conn = get(conn, ~p"/api/external_links")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create external_link" do
    test "renders external_link when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/external_links", external_link: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/external_links/#{id}")

      assert %{
               "id" => ^id,
               "url" => "some url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/external_links", external_link: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update external_link" do
    setup [:create_external_link]

    test "renders external_link when data is valid", %{conn: conn, external_link: %ExternalLink{id: id} = external_link} do
      conn = put(conn, ~p"/api/external_links/#{external_link}", external_link: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/external_links/#{id}")

      assert %{
               "id" => ^id,
               "url" => "some updated url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, external_link: external_link} do
      conn = put(conn, ~p"/api/external_links/#{external_link}", external_link: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete external_link" do
    setup [:create_external_link]

    test "deletes chosen external_link", %{conn: conn, external_link: external_link} do
      conn = delete(conn, ~p"/api/external_links/#{external_link}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/external_links/#{external_link}")
      end
    end
  end

  defp create_external_link(_) do
    external_link = external_link_fixture()
    %{external_link: external_link}
  end
end
