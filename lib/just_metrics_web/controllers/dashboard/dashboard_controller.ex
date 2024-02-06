defmodule JustMetricsWeb.DashboardController do
  # Use `use` to import the `JustMetricsWeb` controller and its functions
  # JustMetricsWeb.controller is a macro that imports stuff we need in our controllers
  # It's defined in lib/just_metrics_web.ex
  use JustMetricsWeb, :controller

  def default(conn, _params) do
    # this is going to look for a `:default` function in a `JustMetricsWeb.DashboardHTML` module, known as a "view"
    render(conn, :default)
  end

  def show(conn, %{"dashboard_id" => dashboard_id} = params) do
    # this is going to look for a `:show` function in a `JustMetricsWeb.DashboardHTML` module, known as a "view"
    render(conn, :show, dashboard_id: dashboard_id)
  end
end
