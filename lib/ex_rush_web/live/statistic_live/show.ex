defmodule ExRushWeb.StatisticLive.Show do
  use ExRushWeb, :live_view

  alias ExRush.Statistics

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:statistic, Statistics.get_statistic!(id))}
  end

  defp page_title(:show), do: "Show Statistic"
  defp page_title(:edit), do: "Edit Statistic"
end
