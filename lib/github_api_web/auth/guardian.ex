defmodule GithubApiWeb.Auth.Guardian do
  use Guardian, otp_app: :github_api

  alias GithubApi.Users.User
  alias GithubApi.Users

  def subject_for_token(%User{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def resource_from_claims(%{"sub" => id}) do
    Users.get_user_by_id(id)
  end

  def authenticate(%{"id" => user_id, "password" => password}) do
    with {:ok, %User{password_hash: hash} = user} <- Users.get_user_by_id(user_id),
         true <- Pbkdf2.verify_pass(password, hash),
         {:ok, token, _claims} <- encode_and_sign(user, %{}, ttl: {1, :minute}) do
      {:ok, token}
    else
      false -> {:error, :unauthorized, "Please verify your credentials"}
      error -> error
    end
  end

  def authenticate(_), do: {:error, :bad_request, "Invalid or missing params"}
end
