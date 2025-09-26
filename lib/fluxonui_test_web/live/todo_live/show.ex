defmodule FluxonUITestWeb.TodoLive.Show do
  use FluxonUITestWeb, :live_view

  alias FluxonUITest.Todos

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Todo {@todo.id}
        <:subtitle>This is a todo record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/todos"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="solid" navigate={~p"/todos/#{@todo}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit todo
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Description">{@todo.description}</:item>
        <:item title="Due">{@todo.due}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Todo")
     |> assign(:todo, Todos.get_todo!(id))}
  end
end
