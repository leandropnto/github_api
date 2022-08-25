defmodule GithubApiWeb.Auth.ErrorHandler do
  alias Guardian.Plug.ErrorHandler
  alias Plug.Conn

  @behaviour ErrorHandler

  def auth_error(conn, {error, _reason}, _opts) do
    body = Jason.encode!(%{message: to_string(error), timestamp: DateTime.now!("Etc/UTC")})
    Conn.send_resp(conn, 401, body)
  end
end
