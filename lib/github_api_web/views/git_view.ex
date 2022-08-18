defmodule GithubApiWeb.GitView do
  use GithubApiWeb, :view

  def render("create.json", %{items: items}) do
    %{
      message: "OK",
      status: 200,
      repos: items
    }
  end

  def render("notfound.json", %{query: query}) do
    %{message: "Repo not found", status: 404, query: query}
  end
end
