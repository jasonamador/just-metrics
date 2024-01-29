defmodule JustMetricsWeb.MetricControllerTest do
  use JustMetricsWeb.ConnCase

  import JustMetrics.MetricsFixtures

  @create_attrs %{name: "some name", unit: "some unit"}
  @update_attrs %{name: "some updated name", unit: "some updated unit"}
  @invalid_attrs %{name: nil, unit: nil}

  describe "index" do
    test "lists all metrics", %{conn: conn} do
      conn = get(conn, ~p"/metrics")
      assert html_response(conn, 200) =~ "Listing Metrics"
    end
  end

  describe "new metric" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/metrics/new")
      assert html_response(conn, 200) =~ "New Metric"
    end
  end

  describe "create metric" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/metrics", metric: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/metrics/#{id}"

      conn = get(conn, ~p"/metrics/#{id}")
      assert html_response(conn, 200) =~ "Metric #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/metrics", metric: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Metric"
    end
  end

  describe "edit metric" do
    setup [:create_metric]

    test "renders form for editing chosen metric", %{conn: conn, metric: metric} do
      conn = get(conn, ~p"/metrics/#{metric}/edit")
      assert html_response(conn, 200) =~ "Edit Metric"
    end
  end

  describe "update metric" do
    setup [:create_metric]

    test "redirects when data is valid", %{conn: conn, metric: metric} do
      conn = put(conn, ~p"/metrics/#{metric}", metric: @update_attrs)
      assert redirected_to(conn) == ~p"/metrics/#{metric}"

      conn = get(conn, ~p"/metrics/#{metric}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, metric: metric} do
      conn = put(conn, ~p"/metrics/#{metric}", metric: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Metric"
    end
  end

  describe "delete metric" do
    setup [:create_metric]

    test "deletes chosen metric", %{conn: conn, metric: metric} do
      conn = delete(conn, ~p"/metrics/#{metric}")
      assert redirected_to(conn) == ~p"/metrics"

      assert_error_sent 404, fn ->
        get(conn, ~p"/metrics/#{metric}")
      end
    end
  end

  defp create_metric(_) do
    metric = metric_fixture()
    %{metric: metric}
  end
end
