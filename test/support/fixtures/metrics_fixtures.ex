defmodule JustMetrics.MetricsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `JustMetrics.Metrics` context.
  """

  @doc """
  Generate a metric.
  """
  def metric_fixture(attrs \\ %{}) do
    {:ok, metric} =
      attrs
      |> Enum.into(%{

      })
      |> JustMetrics.Metrics.create_metric()

    metric
  end

  @doc """
  Generate a metric.
  """
  def metric_fixture(attrs \\ %{}) do
    {:ok, metric} =
      attrs
      |> Enum.into(%{
        name: "some name",
        unit: "some unit"
      })
      |> JustMetrics.Metrics.create_metric()

    metric
  end
end
