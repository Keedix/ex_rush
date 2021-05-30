defmodule ExRushWeb.HomeController do
  use ExRushWeb, :controller

  action_fallback ExRushWeb.FallbackController

  def index(conn, _params) do
    redirect(conn, to: "/statistics")
  end
end
