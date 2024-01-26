defmodule JustMetrics.Repo do
  use Ecto.Repo,
    otp_app: :just_metrics,
    adapter: Ecto.Adapters.Postgres
end
