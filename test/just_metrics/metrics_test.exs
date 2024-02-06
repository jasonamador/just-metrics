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

  describe "measurements" do
    alias JustMetrics.Measurements.Measurement

    import JustMetrics.MetricsFixtures

    @invalid_attrs %{ts: nil, value: nil}

    test "list_measurements/0 returns all measurements" do
      measurement = measurement_fixture()
      assert Metrics.list_measurements() == [measurement]
    end

    test "get_measurement!/1 returns the measurement with given id" do
      measurement = measurement_fixture()
      assert Metrics.get_measurement!(measurement.id) == measurement
    end

    test "create_measurement/1 with valid data creates a measurement" do
      valid_attrs = %{ts: ~U[2024-01-29 07:00:00Z], value: "120.5"}

      assert {:ok, %Measurement{} = measurement} = Metrics.create_measurement(valid_attrs)
      assert measurement.ts == ~U[2024-01-29 07:00:00Z]
      assert measurement.value == Decimal.new("120.5")
    end

    test "create_measurement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Metrics.create_measurement(@invalid_attrs)
    end

    test "update_measurement/2 with valid data updates the measurement" do
      measurement = measurement_fixture()
      update_attrs = %{ts: ~U[2024-01-30 07:00:00Z], value: "456.7"}

      assert {:ok, %Measurement{} = measurement} =
               Metrics.update_measurement(measurement, update_attrs)

      assert measurement.ts == ~U[2024-01-30 07:00:00Z]
      assert measurement.value == Decimal.new("456.7")
    end

    test "update_measurement/2 with invalid data returns error changeset" do
      measurement = measurement_fixture()
      assert {:error, %Ecto.Changeset{}} = Metrics.update_measurement(measurement, @invalid_attrs)
      assert measurement == Metrics.get_measurement!(measurement.id)
    end

    test "delete_measurement/1 deletes the measurement" do
      measurement = measurement_fixture()
      assert {:ok, %Measurement{}} = Metrics.delete_measurement(measurement)
      assert_raise Ecto.NoResultsError, fn -> Metrics.get_measurement!(measurement.id) end
    end

    test "change_measurement/1 returns a measurement changeset" do
      measurement = measurement_fixture()
      assert %Ecto.Changeset{} = Metrics.change_measurement(measurement)
    end
  end
end
