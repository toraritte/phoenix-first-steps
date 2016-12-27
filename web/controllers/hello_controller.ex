defmodule Lofa.HelloController do
  use Lofa.Web, :controller

  def world(conn, %{"name" => name }) do
    render conn, "hello.html", name: name
  end
end
