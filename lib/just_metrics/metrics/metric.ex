defmodule JustMetrics.Metrics.Metric do
  use Ecto.Schema
  import Ecto.Changeset

  schema "metrics" do
    field :name, :string
    field :unit, :string
    belongs_to :user, JustMetrics.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(metric, attrs) do
    metric
    |> cast(attrs, [:name, :unit, :user_id])
    |> validate_required([:name, :unit, :user_id])
  end
end
