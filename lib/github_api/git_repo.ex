defmodule GithubApi.GitRepo do
  

  @derive Jason.Encoder
  defstruct [:id, :name, :description, :html_url, :stargazers_count]


  def build(item) do
    %__MODULE__{
      id: item.id,
      name: item.name,
      description: item.description,
      html_url: item.html_url,
      stargazers_count: item.stargazers_count
    }
  end
end
