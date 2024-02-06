defmodule JustMetricsWeb.MeasurementController do
  use JustMetricsWeb, :controller

  alias JustMetrics.Measurements
  alias JustMetrics.Measurements.Measurement
  alias JustMetrics.Metrics

  # Note on this pattern matching: It is required that the map have string keys, because they are from
  # the web interface (URL, form, etc). If you use atom keys, you will not get a match.
  def index(conn, %{"metric_id" => metric_id}) do
    metric = Metrics.get_metric!(metric_id)
    measurements = Measurements.list_measurements_for_metric(metric)
    render(conn, :index, measurements: measurements, metric: metric)
  end

  def index(conn, %{"metric_id" => metric_id}) do
    metric = Metrics.get_metric!(metric_id)
    measurements = Measurements.list_measurements_for_metric(metric_id)
    render(conn, :index, measurements: measurements)
  end

  def new(conn, %{"metric_id" => metric_id}) do
    changeset = Measurements.change_measurement(%Measurement{ metric_id: metric_id, ts: DateTime.utc_now() })
    render(conn, :new, changeset: changeset, metric_id: metric_id)
  end

  def create(conn, %{"measurement" => measurement, "metric_id" => metric_id}) do
    case Measurements.create_measurement_for_metric(metric_id, measurement) do
      {:ok, measurement} ->
        conn
        |> put_flash(:info, "Measurement created successfully.")
        |> redirect(to: ~p"/metrics/#{measurement.metric_id}/measurements/#{measurement}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def metric_options(conn) do
    Metrics.list_metrics_for_user(conn.assigns.current_user)
    |> Enum.map(&{&1.name, &1.id})
  end

  def show(conn, %{"metric_id" => metric_id, "id" => measurement_id}) do
    metric = Metrics.get_metric!(metric_id)
    measurement = Measurements.get_measurement!(measurement_id)
    render(conn, :show, measurement: measurement, metric: metric)
  end

  def edit(conn, %{"metric_id" => metric_id, "id" => measurement_id}) do
    metric = Metrics.get_metric!(metric_id)
    measurement = Measurements.get_measurement!(measurement_id)
    changeset = Measurements.change_measurement(measurement)

    render(conn, :edit,
      metric: metric,
      measurement: measurement,
      changeset: changeset
    )
  end

  def update(conn, %{"metric_id" => metric_id, "id" => measurement_id, "measurement" => measurement_params}) do
    measurement = Measurements.get_measurement!(measurement_id)
    metric = Metrics.get_metric!(metric_id)

    case Measurements.update_measurement(measurement, measurement_params) do
      {:ok, measurement} ->
        conn
        |> put_flash(:info, "Measurement updated successfully.")
        |> redirect(to: ~p"/metrics/#{metric}/measurements/#{measurement}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, metric: metric, measurement: measurement, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    measurement = Measurements.get_measurement!(id)
    {:ok, _measurement} = Measurements.delete_measurement(measurement)

    conn
    |> put_flash(:info, "Measurement deleted successfully.")
    |> redirect(to: ~p"/measurements")
  end
end
