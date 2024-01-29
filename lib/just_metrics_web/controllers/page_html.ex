defmodule JustMetricsWeb.PageHTML do
  use JustMetricsWeb, :html

  # this macro creates a function in this module for each file under page_html/
  # So `page_html/home.html.heex` becomes a function called `home`, which
  # can be passed to `render/3`: `render(conn, :home, layout: false)`
  embed_templates "page_html/*"
end
