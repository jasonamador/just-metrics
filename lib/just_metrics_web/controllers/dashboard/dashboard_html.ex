defmodule JustMetricsWeb.DashboardHTML do
  # :html is a macro that imports stuff we need for rendering HTML
  use JustMetricsWeb, :html

  # `assigns` is a map of variables that are passed to the template from `conn`
  def default(assigns) do
    ~H"""
    <.dashboard_header name="Default Dashboard" subtitle="After all, it's just metrics!" />
    """
  end

  def dashboard_header(assigns) do
    ~H"""
    <.header>
      <%= @name %>
      <:subtitle><%= @subtitle %></:subtitle>
    </.header>
    <.links />
    """
  end

  def links(assigns) do
    ~H"""
    <div>
      <a href={~p"/metrics"}>
        <.button>Metrics</.button>
      </a>
    </div>
    <div>
      <a href={~p"/measurements"}>
        <.button>Measurements</.button>
      </a>
    </div>
    """
  end

  def show(assigns) do
    name =
      case assigns[:dashboard_metadata] do
        %{name: name} -> name
        _ -> "Untitled Dashboard"
      end

    ~H"""
    <.dashboard_header name={name} subtitle="We don't have a subtitle" />
    <p>We would probably show the dashboard with id: <%= @dashboard_id %></p>
    """
  end

  embed_templates "html/*"
end
