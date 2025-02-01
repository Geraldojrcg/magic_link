defmodule MagicLink.ExternalLinks do
  @moduledoc """
  The ExternalLinks context.
  """

  import Ecto.Query, warn: false
  alias MagicLink.Repo

  alias MagicLink.ExternalLinks.ExternalLink

  @doc """
  Returns the list of external_links.

  ## Examples

      iex> list_external_links()
      [%ExternalLink{}, ...]

  """
  def list_external_links do
    Repo.all(ExternalLink)
  end

  @doc """
  Gets a single external_link.

  Raises `Ecto.NoResultsError` if the External link does not exist.

  ## Examples

      iex> get_external_link!(123)
      %ExternalLink{}

      iex> get_external_link!(456)
      ** (Ecto.NoResultsError)

  """
  def get_external_link!(id), do: Repo.get!(ExternalLink, id)

  @doc """
  Creates a external_link.

  ## Examples

      iex> create_external_link(%{field: value})
      {:ok, %ExternalLink{}}

      iex> create_external_link(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_external_link(attrs \\ %{}) do
    %ExternalLink{}
    |> ExternalLink.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a external_link.

  ## Examples

      iex> update_external_link(external_link, %{field: new_value})
      {:ok, %ExternalLink{}}

      iex> update_external_link(external_link, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_external_link(%ExternalLink{} = external_link, attrs) do
    external_link
    |> ExternalLink.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a external_link.

  ## Examples

      iex> delete_external_link(external_link)
      {:ok, %ExternalLink{}}

      iex> delete_external_link(external_link)
      {:error, %Ecto.Changeset{}}

  """
  def delete_external_link(%ExternalLink{} = external_link) do
    Repo.delete(external_link)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking external_link changes.

  ## Examples

      iex> change_external_link(external_link)
      %Ecto.Changeset{data: %ExternalLink{}}

  """
  def change_external_link(%ExternalLink{} = external_link, attrs \\ %{}) do
    ExternalLink.changeset(external_link, attrs)
  end
end
