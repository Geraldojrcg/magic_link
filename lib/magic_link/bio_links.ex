defmodule MagicLink.BioLinks do
  @moduledoc """
  The BioLinks context.
  """

  import Ecto.Query, warn: false
  alias MagicLink.Repo

  alias MagicLink.BioLinks.BioLink
  alias MagicLink.Links

  @doc """
  Returns the list of bio_links.

  ## Examples

      iex> list_bio_links()
      [%BioLink{}, ...]

  """
  def list_bio_links do
    Repo.all(BioLink, preload: [:link, :external_links])
  end

  @doc """
  Returns the list of bio_links by user.

  ## Examples

      iex> list_bio_links_by_user(123)
      [%BioLink{}, ...]
  """
  def list_bio_links_by_user(user_id) do
    Repo.all(from l in BioLink, where: l.user_id == ^user_id, preload: [:link, :external_links])
  end

  @doc """
  Gets a single bio_link.

  Raises `Ecto.NoResultsError` if the Bio link does not exist.

  ## Examples

      iex> get_bio_link!(123)
      %BioLink{}

      iex> get_bio_link!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bio_link!(id),
    do: Repo.one(from l in BioLink, where: l.id == ^id, preload: [:link, :external_links])

  @doc """
  Gets a single bio_link by link_id.

  Raises `Ecto.NoResultsError` if the Bio link does not exist.

  ### Examples

      iex> get_bio_link_by_link_id!(123)
      %BioLink{}

      iex> get_bio_link_by_link_id!(456)
      ** (Ecto.NoResultsError)
  """
  def get_bio_link_by_link_id!(link_id) do
    Repo.one(from l in BioLink, where: l.link_id == ^link_id, preload: [:link, :external_links])
  end

  @doc """
  Creates a bio_link.

  ## Examples

      iex> create_bio_link(%{field: value})
      {:ok, %BioLink{}}

      iex> create_bio_link(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bio_link(attrs \\ %{}) do
    Repo.transaction(fn ->
      with {:ok, link} <- Links.create_link(%{"user_id" => attrs["user_id"]}),
           {:ok, bio_link} <-
             BioLink.changeset(%BioLink{}, attrs |> Map.put("link_id", link.id)) |> Repo.insert() do
        {:ok, bio_link}
      else
        {:error, changeset} ->
          Repo.rollback(changeset)
          {:error, changeset}
      end
    end)
  end

  @doc """
  Updates a bio_link.

  ## Examples

      iex> update_bio_link(bio_link, %{field: new_value})
      {:ok, %BioLink{}}

      iex> update_bio_link(bio_link, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bio_link(%BioLink{} = bio_link, attrs) do
    bio_link
    |> BioLink.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bio_link.

  ## Examples

      iex> delete_bio_link(bio_link)
      {:ok, %BioLink{}}

      iex> delete_bio_link(bio_link)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bio_link(%BioLink{} = bio_link) do
    Repo.delete(bio_link)
  end

  @doc """
  Deletes a bio_link by id.

  ## Examples

      iex> delete_bio_link_by_id(123)
      :ok

      iex> delete_bio_link_by_id(456)
      ** (Ecto.NoResultsError)

  """
  def delete_bio_link_by_id(id) do
    bio_link = get_bio_link!(id)
    Repo.delete(bio_link)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bio_link changes.

  ## Examples

      iex> change_bio_link(bio_link)
      %Ecto.Changeset{data: %BioLink{}}

  """
  def change_bio_link(%BioLink{} = bio_link, attrs \\ %{}) do
    BioLink.changeset(bio_link, attrs)
  end
end
