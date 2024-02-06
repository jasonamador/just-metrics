defmodule JustMetricsWeb.MeasurementHTML do
  use JustMetricsWeb, :html

  embed_templates "html/*"

  @doc """
  Renders a measurement form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :metric, JustMetrics.Metrics.Metric, required: true
  attr :action, :string, required: true

  def measurement_form(assigns)
end
