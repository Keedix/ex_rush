defmodule ExRushWeb.StatisticLive.Index do
  use ExRushWeb, :live_view

  alias ExRush.Statistics
  alias ExRush.Statistics.Statistic

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :statistics, list_statistics())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Statistic")
    |> assign(:statistic, Statistics.get_statistic!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Statistic")
    |> assign(:statistic, %Statistic{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Statistics")
    |> assign(:statistic, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    statistic = Statistics.get_statistic!(id)
    {:ok, _} = Statistics.delete_statistic(statistic)

    {:noreply, assign(socket, :statistics, list_statistics())}
  end

  defp list_statistics do
    Statistics.list_statistics()
  end
end
