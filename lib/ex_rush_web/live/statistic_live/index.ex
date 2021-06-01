defmodule ExRushWeb.StatisticLive.Index do
  use ExRushWeb, :live_view

  alias ExRush.Statistics

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign_common(socket)}
  end

  @impl true
  def handle_params(%{"order_by" => order_by, "direction" => direction}, _sessions, socket) do
    statistics = Statistics.list_statistics_by(order_by, direction)

    {:noreply,
     socket
     |> assign(:statistics, statistics)
     |> assign(:path, %{"order_by" => order_by, "direction" => direction})}
  end

  def handle_params(%{"player" => player}, _sessions, socket) do
    statistics = list_statistics_for_player(player)

    {:noreply,
     socket
     |> assign(:statistics, statistics)
     |> assign(:path, %{"player" => player})}
  end

  def handle_params(_params, _sessions, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event("search", %{"_csrf_token" => _, "statistic" => %{"player" => player}}, socket) do
    statistics = list_statistics_for_player(player)
    path = Routes.live_path(socket, ExRushWeb.StatisticLive.Index, %{"player" => player})

    {:noreply,
     socket
     |> assign(:statistics, statistics)
     |> assign(:path, %{"player" => player})
     |> push_patch(to: path)}
  end

  def handle_event("autocomplete_player", %{"_csrf_token" => _, "statistic" => statistic}, socket) do
    %{"player" => player} = statistic
    players = list_statistics_for_player(player)
    {:noreply, assign(socket, :autocomplete_player, players)}
  end

  def handle_event("clear", _params, socket) do
    path = Routes.live_path(socket, ExRushWeb.StatisticLive.Index, %{})

    {:noreply,
     socket
     |> assign_common
     |> assign(:path, %{})
     |> push_patch(to: path)}
  end

  # private

  defp list_statistics do
    Statistics.list_statistics()
  end

  defp list_statistics_for_player(player) do
    with_empty_check(player, &Statistics.list_statistics_by/1, %{player: player})
  end

  defp with_empty_check(player, fun, args) do
    if String.trim(player) == "" do
      Statistics.list_statistics()
    else
      fun.(args)
    end
  end

  defp assign_common(socket) do
    socket
    |> assign(:statistics, list_statistics())
    |> assign(:autocomplete_player, [])
    |> assign(:path, %{})
    |> assign(:changeset, Statistics.change_statistic(%Statistics.Statistic{}))
  end
end
