# require IEx

defmodule Lofa.UserController do
  use Lofa.Web, :controller
  plug :authenticate when action in [:index, :show]

  def index(conn, _params) do
    users = Repo.all(Lofa.User)
    # IEx.pry
    render conn, "index.html", users: users
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(Lofa.User, id)
    render conn, "show.html", user: user
  end

  def new(conn, _params) do
    changeset = Lofa.User.changeset(%Lofa.User{})
    # IEx.pry
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params} = params) do
    # IEx.pry
    changeset = Lofa.User.registration_changeset(%Lofa.User{}, user_params)
    case Lofa.Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> Lofa.Auth.login(user)
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: page_path(conn, :index))
      |> halt()
    end
  end
end
