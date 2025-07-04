defmodule MagicLinkWeb.DashboardChannel do
  use MagicLinkWeb, :channel

  @impl true
  def join("dashboard:lobby", _, socket) do
    {:ok, socket}
  end
end
