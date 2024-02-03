defmodule JustMetricsWeb.MeasurementHTML do
  use JustMetricsWeb, :html

  embed_templates "measurement_html/*"

  @doc """
  Renders a measurement form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def measurement_form(assigns)
end
