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

    <button>
    <img src="images/light-off.svg">
    </button>

    <button>
    <img src="images/light-on.svg">
    </button>
    """
  end
end
