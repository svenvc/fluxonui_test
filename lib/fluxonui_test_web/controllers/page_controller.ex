defmodule FluxonUITestWeb.PageController do
  use FluxonUITestWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
