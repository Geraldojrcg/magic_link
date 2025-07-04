defmodule MagicLink.Links do
  @moduledoc """
  The Links context.
  """

  import Ecto.Query, warn: false
  alias MagicLink.Repo

  alias MagicLink.Links.Link

  @doc """
  Returns the list of links.

  ## Examples

      iex> list_links()
      [%Link{}, ...]

  """
  def list_links do
    Repo.all(Link)
  end

  @doc """
  Returns the list of links by user.

  ## Examples

      iex> list_links_by_user(123)
      [%Link{}, ...]
  """
  def list_links_by_user(user_id) do
    Repo.all(
      from l in Link,
        where: l.user_id == ^user_id and l.original_url != "",
        order_by: [desc: l.inserted_at]
    )
  end

  @doc """
  Gets a single link.

  Raises `Ecto.NoResultsError` if the Link does not exist.

  ## Examples

      iex> get_link!(123)
      %Link{}

      iex> get_link!(456)
      ** (Ecto.NoResultsError)

  """
  def get_link!(id), do: Repo.get!(Link, id)

  @doc """
  Gets a single link by short_id.

  Raises `Ecto.NoResultsError` if the Link does not exist.

  ## Examples

      iex> get_link_by_short_id!("short_id")
      %Link{}

      iex> get_link_by_short_id!("unknown_short_id")
      ** (Ecto.NoResultsError)

  """
  def get_link_by_short_id!(short_id) do
    Repo.one(
      from l in Link,
        where: l.short_id == ^short_id,
        preload: [:user]
    )
    |> case do
      nil ->
        {:error, "Link not found"}

      link ->
        link
        |> update_link(%{visit_count: link.visit_count + 1})
    end
  end

  @doc """
  Creates a link.

  ## Examples

      iex> create_link(%{field: value})
      {:ok, %Link{}}

      iex> create_link(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_link(attrs \\ %{}) do
    short_id = create_random_short_id()

    %Link{}
    |> Link.changeset(
      attrs
      |> Map.put("short_id", short_id)
      |> Map.put("short_url", get_short_url(short_id))
    )
    |> Repo.insert()
  end

  @doc """
  Updates a link.

  ## Examples

      iex> update_link(link, %{field: new_value})
      {:ok, %Link{}}

      iex> update_link(link, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_link(%Link{} = link, attrs) do
    link
    |> Link.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a link.

  ## Examples

      iex> delete_link(link)
      {:ok, %Link{}}

      iex> delete_link(link)
      {:error, %Ecto.Changeset{}}

  """
  def delete_link(%Link{} = link) do
    Repo.delete(link)
  end

  @doc """
  Deletes a link by id.

  ## Examples

      iex> delete_link_by_id(123)
      {:ok, %Link{}}

      iex> delete_link_by_id(456)
      {:error, %Ecto.Changeset{}}

  """
  def delete_link_by_id(id) do
    link = get_link!(id)
    delete_link(link)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking link changes.

  ## Examples

      iex> change_link(link)
      %Ecto.Changeset{data: %Link{}}

  """
  def change_link(%Link{} = link, attrs \\ %{}) do
    Link.changeset(link, attrs)
  end

  defp create_random_short_id() do
    :crypto.strong_rand_bytes(4) |> Base.url_encode64()
  end

  defp get_short_url(short_id) do
    base_url = Application.get_env(:magic_link, :base_url, "")
    base_url <> "/l/" <> short_id
  end
end
