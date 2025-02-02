defmodule MagicLinkWeb.UserConfirmationInstructionsLive do
  use MagicLinkWeb, :live_view

  alias MagicLink.Accounts

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-sm px-4 py-20 sm:px-6 lg:px-8">
      <.header class="text-center">
        Não recebeu as instruções de confirmação?
        <:subtitle>Enviaremos um novo link de confirmação para seu e-mail</:subtitle>
      </.header>

      <.simple_form for={@form} id="resend_confirmation_form" phx-submit="send_instructions">
        <.input field={@form[:email]} type="email" placeholder="Email" required />
        <:actions>
          <.button phx-disable-with="Enviando..." class="w-full">
            Reenviar instruções de confirmação
          </.button>
        </:actions>
      </.simple_form>

      <p class="text-center mt-4">
        <.link href={~p"/users/register"}>Registrar</.link>
        | <.link href={~p"/users/log_in"}>Entrar</.link>
      </p>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, form: to_form(%{}, as: "user"))}
  end

  def handle_event("send_instructions", %{"user" => %{"email" => email}}, socket) do
    if user = Accounts.get_user_by_email(email) do
      Accounts.deliver_user_confirmation_instructions(
        user,
        &url(~p"/users/confirm/#{&1}")
      )
    end

    info =
      "Se seu e-mail estiver em nosso sistema e ainda não tiver sido confirmado, você receberá um e-mail com instruções em breve."

    {:noreply,
     socket
     |> put_flash(:info, info)
     |> redirect(to: ~p"/")}
  end
end
