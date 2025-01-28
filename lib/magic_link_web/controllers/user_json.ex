defmodule MagicLinkWeb.UserJSON do
  alias MagicLink.Accounts.User

  @doc """
  Renders a single link.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  def serialize(%User{} = user) do
    %{data: data(user)}
  end

  def serialize(nil), do: %{data: nil}

  defp data(%User{} = user) do
    %{
      id: user.id,
      email: user.email,
      name: user.name,
      inserted_at: user.inserted_at
    }
  end
end
