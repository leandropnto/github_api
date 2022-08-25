defmodule GithubApiWeb.Auth.RefresToken do
  alias GithubApiWeb.Auth.Guardian

  @behaviour Plug
  alias Plug.Conn

  def init(_opts) do
  end

  def call(conn, _opts) do
    token = Guardian.Plug.current_token(conn)

    with {:ok, _old_stuff, {new_token, _new_claims}} <- Guardian.refresh(token) do
      conn |> Conn.put_resp_header("refresh", new_token)
    else
      _ ->
        conn
    end
  end
end
