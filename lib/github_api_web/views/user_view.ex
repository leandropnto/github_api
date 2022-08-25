defmodule GithubApiWeb.UserView do
  use GithubApiWeb, :view
  alias GithubApiWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      login: user.login,
      password: user.password
    }
  end

  def render("sign_in.json", %{token: token}) do
    %{
      token: token
    }
  end
end
