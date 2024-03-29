defmodule JustMetricsWeb.MetricHTML do
  use JustMetricsWeb, :html

  embed_templates "html/*"

  @doc """
  Renders a metric form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def metric_form(assigns)
end
