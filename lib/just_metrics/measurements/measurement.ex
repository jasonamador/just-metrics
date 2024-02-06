defmodule JustMetrics.Measurements.Measurement do
  use Ecto.Schema
  import Ecto.Changeset

  schema "measurements" do
    field :ts, :utc_datetime
    field :value, :decimal
    belongs_to :metric, JustMetrics.Metrics.Metric

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(measurement, attrs) do
    measurement
    |> cast(attrs, [:ts, :value, :metric_id])
    |> validate_required([:ts, :value, :metric_id])
  end
end
