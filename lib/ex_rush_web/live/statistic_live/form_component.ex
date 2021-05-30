defmodule ExRushWeb.StatisticLive.FormComponent do
  use ExRushWeb, :live_component

  alias ExRush.Statistics

  @impl true
  def update(%{statistic: statistic} = assigns, socket) do
    changeset = Statistics.change_statistic(statistic)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"statistic" => statistic_params}, socket) do
    changeset =
      socket.assigns.statistic
      |> Statistics.change_statistic(statistic_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"statistic" => statistic_params}, socket) do
    save_statistic(socket, socket.assigns.action, statistic_params)
  end

  defp save_statistic(socket, :edit, statistic_params) do
    case Statistics.update_statistic(socket.assigns.statistic, statistic_params) do
      {:ok, _statistic} ->
        {:noreply,
         socket
         |> put_flash(:info, "Statistic updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_statistic(socket, :new, statistic_params) do
    case Statistics.create_statistic(statistic_params) do
      {:ok, _statistic} ->
        {:noreply,
         socket
         |> put_flash(:info, "Statistic created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
