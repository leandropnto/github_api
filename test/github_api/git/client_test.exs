defmodule GithubApi.Git.ClientTest do
  use ExUnit.Case, async: true
  alias GithubApi.Git.Client
  alias Plug.Conn

  describe "get_repo/2" do
    setup do
      bypass = Bypass.open()
      {:ok, bypass: bypass}
    end

    test "when there is a valid repo name", %{bypass: bypass} do
      repo = "leandropnto"
      url = endpoint_url(bypass.port)

      body = ~s(
	         [{
            "id": "123",
            "name": "Leandro",
            "description": "Esse é um teste",
            "html_url": "https://github.com/leandropnto/brewer",
            "stargazers_count": 0
            }]
        )

      Bypass.expect(bypass, "GET", "users/#{repo}/repos", fn conn ->
        conn
        |> Conn.put_req_header("accept", "application/json")
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body)
      end)

      expected_response =
        {:ok,
         [
           %GithubApi.GitRepo{
             description: "Esse é um teste",
             html_url: "https://github.com/leandropnto/brewer",
             id: "123",
             name: "Leandro",
             stargazers_count: 0
           }
         ]}

      response = Client.get_repos(url, repo)

      assert response == expected_response
    end
  end

  @doc """
   Retorna a url para o teste local no bypass
  """
  defp endpoint_url(port), do: "http://localhost:#{port}/"
end
