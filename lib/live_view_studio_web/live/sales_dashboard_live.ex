defmodule LiveViewStudioWeb.SalesDashboardLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Sales

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(1000, self(), :tick)
    end

    expiration_time = Timex.shift(Timex.now(), hours: 1)

    socket = assign_stats(socket)

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""

    <h1>Sales Dashboard</h1>
    <div id="dashboard">
    <div class="stats">
    <div class="stat">
    <span class="value">
    <%= @new_orders %>
    </span>
    <span class="name">
    New Orders
    </span>
    </div>
    <div class="stat">
    <span class="value">
    <%= @sales_amount %>
    </span>
    <span class="name">
    Satisfaction
    </span>
    </div>
    <div class="stat">
    <span class="value">
    <%= @satisfaction %>
    </span>
    <span class="name">
    Satisfaction
    </span>
    </div>
    </div>
    <button phx-click="refresh">
    <img src="images/refresh.svg">
    Refresh
    </button>
    </div>
    """
  end

  def handle_event("refresh", _, socket) do
    socket = assign_stats(socket)
    {:noreply, socket}
  end

  def handle_info(:tick, socket) do
    socket = assign_stats(socket)
    {:noreply, socket}
  end

  defp assign_stats(socket) do
    assign(socket,
      new_orders: Sales.new_orders(),
      sales_amount: Sales.sales_amount(),
      satisfaction: Sales.satisfaction()
    )
  end

  defp time_remaining(expiration_time) do
    DateTime.diff(expiration_time, Timex.now())
  end

  defp format_time(time) do
    time
    |> Timex.Duration.from_seconds()
    |> Timex.format_duration(:humanized)
  end

  def handle_info(:tick, socket) do
    expiration_time = socket.assigns.expiration_time
    socket = assign(socket, time_remaining: time_remaining(expiration_time))
    {:noreply, socket}
  end
end
