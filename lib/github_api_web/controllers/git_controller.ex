defmodule GithubApiWeb.GitController do
  use GithubApiWeb, :controller
  alias GithubApi.Git.Client

  def index(conn, params) do
    with %{"repo" => repo} <- params,
         {:ok, items} <- Client.get_repos(repo) do
      conn
      |> put_status(:created)
      |> render("create.json", items: items)
    else
      _error ->
        conn
        |> put_status(:not_found)
        |> render("notfound.json", query: params["repo"])

      nil ->
        conn
        |> put_status(:not_found)
        |> render("notfound.json", query: params)
    end
  end
end
