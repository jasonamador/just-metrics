defmodule JustMetricsWeb.MetricController do
  use JustMetricsWeb, :controller

  alias JustMetrics.Metrics
  alias JustMetrics.Metrics.Metric

  def index(conn, _params) do
    metrics = Metrics.list_metrics_for_user(conn.assigns.current_user)
    render(conn, :index, metrics: metrics)
  end

  def new(conn, _params) do
    changeset = Metrics.change_metric(%Metric{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"metric" => metric_params}) do
    case Metrics.create_metric(metric_params, conn.assigns.current_user) do
      {:ok, metric} ->
        conn
        |> put_flash(:info, "Metric created successfully.")
        |> redirect(to: ~p"/metrics/#{metric}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    metric = Metrics.get_metric!(id)
    render(conn, :show, metric: metric)
  end

  def edit(conn, %{"id" => id}) do
    metric = Metrics.get_metric!(id)
    changeset = Metrics.change_metric(metric)
    render(conn, :edit, metric: metric, changeset: changeset)
  end

  def update(conn, %{"id" => id, "metric" => metric_params}) do
    metric = Metrics.get_metric!(id)

    case Metrics.update_metric(metric, metric_params) do
      {:ok, metric} ->
        conn
        |> put_flash(:info, "Metric updated successfully.")
        |> redirect(to: ~p"/metrics/#{metric}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, metric: metric, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    metric = Metrics.get_metric!(id)
    {:ok, _metric} = Metrics.delete_metric(metric)

    conn
    |> put_flash(:info, "Metric deleted successfully.")
    |> redirect(to: ~p"/metrics")
  end
end
