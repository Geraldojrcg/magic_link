defmodule MagicLinkWeb.UserLoginLive do
  use MagicLinkWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-md px-4 py-20 sm:px-6 lg:px-8">
      <.header class="text-center">
        Entrar na conta
        <:subtitle>
          Não tem uma conta?
          <.link navigate={~p"/users/register"} class="font-semibold text-brand hover:underline">
            Cadastre-se
          </.link>
          agora.
        </:subtitle>
      </.header>

      <.simple_form for={@form} id="login_form" action={~p"/users/log_in"} phx-update="ignore">
        <.input field={@form[:email]} type="email" label="Email" required />
        <.input field={@form[:password]} type="password" label="Senha" required />

        <:actions>
          <.input field={@form[:remember_me]} type="checkbox" label="Mantenha-me conectado" />
          <.link href={~p"/users/reset_password"} class="text-sm font-semibold">
            Esqueceu sua senha?
          </.link>
        </:actions>
        <:actions>
          <.button phx-disable-with="Entrando..." class="w-full">
            Entrar <span aria-hidden="true">→</span>
          </.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    email = Phoenix.Flash.get(socket.assigns.flash, :email)
    form = to_form(%{"email" => email}, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end
end
