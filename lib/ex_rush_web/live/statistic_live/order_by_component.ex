defmodule ExRushWeb.OrderByComponent do
  use ExRushWeb, :live_component

  @impl true
  def render(assigns) do
    ~L"""
    <div class="flex flex-row items-center">
      <p class="flex-1 w-2/4">
        <%= assigns.title %>
      </p>
      <div class="flex-1 w-2/4">
        <%= live_patch to: Routes.live_path(@socket, ExRushWeb.StatisticLive.Index, %{"order_by" => assigns.order_by, "direction" => "asc"})  do %>
          <div class="cursor-pointer hover:text-yellow-200 flex justify-center">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-7 w-7" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 4h13M3 8h9m-9 4h6m4 0l4-4m0 0l4 4m-4-4v12" />
            </svg>
          </div>
        <% end %>
        <%= live_patch to: Routes.live_path(@socket, ExRushWeb.StatisticLive.Index, %{"order_by" => assigns.order_by, "direction" => "desc"})  do %>
          <div class="cursor-pointer hover:text-yellow-200 flex justify-center">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-7 w-7" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 4h13M3 8h9m-9 4h9m5-4v12m0 0l-4-4m4 4l4-4" />
            </svg>
          </div>
        <% end %>
      </div>
    </div>
    """
  end
end
