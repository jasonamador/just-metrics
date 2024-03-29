defmodule JustMetrics.Measurements do
  import Ecto.Query, warn: false

  # alias Ecto.Repo
  alias JustMetrics.Repo
  alias JustMetrics.Measurements.Measurement

  @doc """
  Returns the list of measurements for a metric.
  @param metric_id 
  """
  def list_measurements_for_metric(metric) do
    Repo.all(from m in Measurement, where: m.metric_id == ^metric.id)
  end

  def list_measurements_for_metric(metric, limit) do
    Repo.all(from m in Measurement, where: m.metric_id == ^metric.id, limit: ^limit)
  end

  @doc """
  Gets a single measurement.

  Raises `Ecto.NoResultsError` if the Measurement does not exist.

  ## Examples

      iex> get_measurement!(123)
      %Measurement{}

      iex> get_measurement!(456)
      ** (Ecto.NoResultsError)

  """
  def get_measurement!(id), do: Repo.get!(Measurement, id)

  def get_measurement_with_metric!(metric_id, measurement_id) do
    from(m in Measurement, where: m.id == ^measurement_id and m.metric_id == ^metric_id)
    |> Repo.preload(:metric)
    |> Repo.one!()
  end

  @doc """
  Creates a measurement.

  ## Examples

      iex> create_measurement(%{field: value})
      {:ok, %Measurement{}}

      iex> create_measurement(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_measurement(attrs \\ %{}) do
    %Measurement{}
    |> Measurement.changeset(attrs)
    |> Repo.insert()
  end

  def create_measurement_for_metric(metric_id, attrs) do
    %Measurement{}
    |> Measurement.changeset(Map.put(attrs, "metric_id", metric_id))
    |> Repo.insert()
  end

  @doc """
  Updates a measurement.

  ## Examples

      iex> update_measurement(measurement, %{field: new_value})
      {:ok, %Measurement{}}

      iex> update_measurement(measurement, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_measurement(%Measurement{} = measurement, attrs) do
    measurement
    |> Measurement.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a measurement.

  ## Examples

      iex> delete_measurement(measurement)
      {:ok, %Measurement{}}

      iex> delete_measurement(measurement)
      {:error, %Ecto.Changeset{}}

  """
  def delete_measurement(%Measurement{} = measurement) do
    Repo.delete(measurement)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking measurement changes.

  ## Examples

      iex> change_measurement(measurement)
      %Ecto.Changeset{data: %Measurement{}}

  """
  def change_measurement(%Measurement{} = measurement, attrs \\ %{}) do
    Measurement.changeset(measurement, attrs)
  end
end
