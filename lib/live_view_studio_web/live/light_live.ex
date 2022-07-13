defmodule LiveViewStudioWeb.LightLive do
  use LiveViewStudioWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, :brightness, 10)
    IO.inspect(socket)
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Front Porch Light</h1>
    <div id="light">
    <div class="meter">
    <span style="width: <%= @brightness %>%">
    <%= @brightness %>%
    </span>
    </div>
    <form phx-change="update">
    <input type="range" min="0" max="100" name="brightness" value="<%= @brightness%>" />
    </form>


    """
  end

  def handle_event("update", %{"brightness" => brightness}, socket) do
    brightness = String.to_integer(brightness)
    socket = assign(socket, brightness: brightness)
    {:noreply, socket}
  end
end
