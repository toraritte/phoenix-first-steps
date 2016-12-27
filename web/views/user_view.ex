defmodule Lofa.UserView do
  use Lofa.Web, :view

  def first_name(%Lofa.User{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end
end
