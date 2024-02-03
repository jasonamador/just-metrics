defmodule JustMetricsWeb.MeasurementController do
  use JustMetricsWeb, :controller

  alias JustMetrics.Metrics
  alias JustMetrics.Metrics.Measurement

  def index(conn, _params) do
    measurements = Metrics.list_measurements_with_metric_for_user(conn.assigns.current_user)
    render(conn, :index, measurements: measurements)
  end

  def new(conn, _params) do
    changeset = Metrics.change_measurement(%Measurement{})
    render(conn, :new, changeset: changeset, metric_options: metric_options(conn))
  end

  def create(conn, %{"measurement" => measurement_params}) do
    case Metrics.create_measurement(measurement_params) do
      {:ok, measurement} ->
        conn
        |> put_flash(:info, "Measurement created successfully.")
        |> redirect(to: ~p"/measurements/#{measurement}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset, metric_options: metric_options(conn))
    end
  end

  def metric_options(conn) do
    Metrics.list_metrics_for_user(conn.assigns.current_user)
    |> Enum.map(&{&1.name, &1.id})
  end

  def show(conn, %{"id" => id}) do
    measurement = Metrics.get_measurement!(id)
    render(conn, :show, measurement: measurement)
  end

  def edit(conn, %{"id" => id}) do
    measurement = Metrics.get_measurement!(id)
    changeset = Metrics.change_measurement(measurement)
    render(conn, :edit, measurement: measurement, changeset: changeset, metric_options: metric_options(conn))
  end

  def update(conn, %{"id" => id, "measurement" => measurement_params}) do
    measurement = Metrics.get_measurement!(id)

    case Metrics.update_measurement(measurement, measurement_params) do
      {:ok, measurement} ->
        conn
        |> put_flash(:info, "Measurement updated successfully.")
        |> redirect(to: ~p"/measurements/#{measurement}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, measurement: measurement, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    measurement = Metrics.get_measurement!(id)
    {:ok, _measurement} = Metrics.delete_measurement(measurement)

    conn
    |> put_flash(:info, "Measurement deleted successfully.")
    |> redirect(to: ~p"/measurements")
  end
end
