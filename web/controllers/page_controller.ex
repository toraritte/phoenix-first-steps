# require IEx
defmodule Lofa.PageController do
  use Lofa.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
