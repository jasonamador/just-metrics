defmodule JustMetricsWeb.PageController do
  use JustMetricsWeb, :controller
  # This macro uses Phoenix.Controller with html and json formats, 
  # wired to JustMetricsWeb.Layouts

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end
end
