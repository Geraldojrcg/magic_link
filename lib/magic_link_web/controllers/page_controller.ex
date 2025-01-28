defmodule MagicLinkWeb.PageController do
  use MagicLinkWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render_inertia(conn, "Home")
  end
end
