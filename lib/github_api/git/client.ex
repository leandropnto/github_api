defmodule GithubApi.Git.Client do
  use Tesla
  plug Tesla.Middleware.JSON
  @base_url "https://api.github.com/users/"

  alias Tesla.Env

  def get_repos(user) do
    url = "#{@base_url}#{user}/repos"

    get(url)
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 404}}) do
    {:error, :not_found}
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    IO.inspect(body)
    {:ok, Enum.map(body, &map_item/1)}
  end

  defp map_item(%{
         "id" => id,
         "name" => name,
         "description" => description,
         "html_url" => html_url,
         "stargazers_count" => stargazers_count
       }) do
    %GithubApi.GitRepo{
      id: id,
      name: name,
      description: description || "Sem descrição",
      html_url: html_url,
      stargazers_count: stargazers_count
    }
  end
end
