defmodule BooksWeb.PublicController do
  use BooksWeb, :controller

  def index(conn, _params) do
    render conn
  end
end
