defmodule GithubApi.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `GithubApi.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        login: "some login",
        password: "some password"
      })
      |> GithubApi.Users.create_user()

    user
  end
end
