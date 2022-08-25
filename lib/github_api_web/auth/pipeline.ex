defmodule GithubApiWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :github_api

  # Plugs utilizados no guardian
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
  plug GithubApiWeb.Auth.RefresToken
end
