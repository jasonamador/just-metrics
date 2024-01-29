defmodule JustMetrics.MetricsTest do
  use JustMetrics.DataCase

  alias JustMetrics.Metrics

  describe "metrics" do
    alias JustMetrics.Metrics.Metric

    import JustMetrics.MetricsFixtures

    @invalid_attrs %{}

    test "list_metrics/0 returns all metrics" do
      metric = metric_fixture()
      assert Metrics.list_metrics() == [metric]
    end

    test "get_metric!/1 returns the metric with given id" do
      metric = metric_fixture()
      assert Metrics.get_metric!(metric.id) == metric
    end

    test "create_metric/1 with valid data creates a metric" do
      valid_attrs = %{}

      assert {:ok, %Metric{} = metric} = Metrics.create_metric(valid_attrs)
    end

    test "create_metric/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Metrics.create_metric(@invalid_attrs)
    end

    test "update_metric/2 with valid data updates the metric" do
      metric = metric_fixture()
      update_attrs = %{}

      assert {:ok, %Metric{} = metric} = Metrics.update_metric(metric, update_attrs)
    end

    test "update_metric/2 with invalid data returns error changeset" do
      metric = metric_fixture()
      assert {:error, %Ecto.Changeset{}} = Metrics.update_metric(metric, @invalid_attrs)
      assert metric == Metrics.get_metric!(metric.id)
    end

    test "delete_metric/1 deletes the metric" do
      metric = metric_fixture()
      assert {:ok, %Metric{}} = Metrics.delete_metric(metric)
      assert_raise Ecto.NoResultsError, fn -> Metrics.get_metric!(metric.id) end
    end

    test "change_metric/1 returns a metric changeset" do
      metric = metric_fixture()
      assert %Ecto.Changeset{} = Metrics.change_metric(metric)
    end
  end

  describe "metrics" do
    alias JustMetrics.Metrics.Metric

    import JustMetrics.MetricsFixtures

    @invalid_attrs %{name: nil, unit: nil}

    test "list_metrics/0 returns all metrics" do
      metric = metric_fixture()
      assert Metrics.list_metrics() == [metric]
    end

    test "get_metric!/1 returns the metric with given id" do
      metric = metric_fixture()
      assert Metrics.get_metric!(metric.id) == metric
    end

    test "create_metric/1 with valid data creates a metric" do
      valid_attrs = %{name: "some name", unit: "some unit"}

      assert {:ok, %Metric{} = metric} = Metrics.create_metric(valid_attrs)
      assert metric.name == "some name"
      assert metric.unit == "some unit"
    end

    test "create_metric/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Metrics.create_metric(@invalid_attrs)
    end

    test "update_metric/2 with valid data updates the metric" do
      metric = metric_fixture()
      update_attrs = %{name: "some updated name", unit: "some updated unit"}

      assert {:ok, %Metric{} = metric} = Metrics.update_metric(metric, update_attrs)
      assert metric.name == "some updated name"
      assert metric.unit == "some updated unit"
    end

    test "update_metric/2 with invalid data returns error changeset" do
      metric = metric_fixture()
      assert {:error, %Ecto.Changeset{}} = Metrics.update_metric(metric, @invalid_attrs)
      assert metric == Metrics.get_metric!(metric.id)
    end

    test "delete_metric/1 deletes the metric" do
      metric = metric_fixture()
      assert {:ok, %Metric{}} = Metrics.delete_metric(metric)
      assert_raise Ecto.NoResultsError, fn -> Metrics.get_metric!(metric.id) end
    end

    test "change_metric/1 returns a metric changeset" do
      metric = metric_fixture()
      assert %Ecto.Changeset{} = Metrics.change_metric(metric)
    end
  end
end
