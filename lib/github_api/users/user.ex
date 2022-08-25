defmodule GithubApi.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Jason.Encoder, only: [:id, :login]}

  schema "users" do
    field :login, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:login, :password])
    |> validate_required([:login, :password])
    |> validate_password(attrs)
  end

  def validate_password(changeset, params) do
    updating? = Map.has_key?(params, "id")
    password? = Map.has_key?(params, "password")

    IO.inspect(params)

    cond do
      password? ->
        IO.puts("Entrou no #1")

        changeset
        |> validate_required([:password])
        |> validate_length(:password, min: 6)
        |> put_password_hash()

      !password? && !updating? ->
        IO.puts("Entrou no #2")

        changeset
        |> validate_required([:password])

      true ->
        IO.puts("Entrou no #3")
        changeset
    end
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(%Changeset{} = changeset), do: changeset
end
