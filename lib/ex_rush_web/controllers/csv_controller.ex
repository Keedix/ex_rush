defmodule ExRushWeb.CsvController do
  use ExRushWeb, :controller

  alias ExRush.Statistics

  def download(conn, params) do
    {statistics, filename} = get_statistics(params)

    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=#{filename}")
    |> put_root_layout(false)
    |> put_status(200)
    |> render("report.csv", statistics: statistics)
  end

  defp get_statistics(params) do
    case params do
      %{"player" => player} ->
        {Statistics.list_statistics_by(%{player: player}), create_filename([player])}

      %{"order_by" => order_by, "direction" => direction} ->
        {Statistics.list_statistics_by(order_by, direction),
         create_filename([order_by, direction])}

      _ ->
        {Statistics.list_statistics(), create_filename()}
    end
  end

  defp create_filename(suffixes \\ [], base \\ "statistics") do
    Enum.join([base | suffixes], "_")
  end
end
