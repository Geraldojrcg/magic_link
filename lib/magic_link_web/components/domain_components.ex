defmodule MagicLinkWeb.DomainComponents do
  use MagicLinkWeb, :verified_routes
  use Phoenix.LiveComponent

  alias Phoenix.LiveView.JS

  attr :current_user, :map, default: %{}, doc: "the current user"

  def navbar(assigns) do
    ~H"""
    <nav class="bg-primary text-primary-foreground">
      <div class="container mx-auto px-4 py-3 flex justify-between items-center">
        <a href={~p"/links"} class="text-xl font-bold flex items-center space-x-2">
          <img src={~p"/images/logo.png"} alt="Magic Link Logo" class="h-8 w-auto object-contain" />
          Magic Link
        </a>
        <div class="relative group">
          <button
            class="flex items-center space-x-2 bg-primary-foreground/10 hover:bg-primary-foreground/20 transition-colors duration-200 px-3 py-2 rounded-md"
            phx-click={JS.remove_class("hidden", to: "#dropdown")}
          >
            <div class="w-8 h-8 bg-gray-300 rounded-full flex items-center justify-center text-primary font-bold">
              {String.at(@current_user.name, 0)}
            </div>
            <span>{@current_user.email}</span>
            <svg
              xmlns="http://www.w3.org/2000/svg"
              class="h-4 w-4"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
            >
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
            </svg>
          </button>
          <div
            id="dropdown"
            class="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 hidden"
            phx-click-away={JS.add_class("hidden", to: "#dropdown")}
          >
            <a
              href={~p"/users/settings"}
              class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
            >
              Ver Perfil
            </a>
            <.form for={} action={~p"/users/log_out"} method="delete">
              <button
                type="submit"
                class="block w-full text-left px-4 py-2 text-sm text-red-700 hover:bg-gray-100"
              >
                Sair
              </button>
            </.form>
          </div>
        </div>
      </div>
    </nav>
    """
  end
end
