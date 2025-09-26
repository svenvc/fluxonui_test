defmodule FluxonUITestWeb.TodoLive.Index do
  use FluxonUITestWeb, :live_view

  alias FluxonUITest.Todos

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Listing Todos
        <:actions>
          <.button variant="solid" navigate={~p"/todos/new"}>
            <.icon name="hero-plus" /> New Todo
          </.button>
        </:actions>
      </.header>

    <!-- <.table
        id="todos"
        rows={@streams.todos}
        row_click={fn {_id, todo} -> JS.navigate(~p"/todos/#{todo}") end}
      >
        <:col :let={{_id, todo}} label="Description">{todo.description}</:col>
        <:col :let={{_id, todo}} label="Due">{todo.due}</:col>
        <:action :let={{_id, todo}}>
          <div class="sr-only">
            <.link navigate={~p"/todos/#{todo}"}>Show</.link>
          </div>
          <.link navigate={~p"/todos/#{todo}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, todo}}>
          <.link
            phx-click={JS.push("delete", value: %{id: todo.id}) |> hide("##{id}")}
            data-confirm="Are you sure?"
          >
            Delete
          </.link>
        </:action>
      </.table> -->

      <.table id="todos">
        <.table_head>
          <:col>Description</:col>
          <:col>Due</:col>
          <:col>Actions</:col>
        </.table_head>
        <.table_body>
          <.table_row
            :for={todo <- @todos}
            id={"todo-#{todo.id}"}
            phx-click={JS.navigate(~p"/todos/#{todo}")}
            phx-value-id={todo.id}
            class="cursor-pointer hover:bg-accent/50"
          >
            <:cell>{todo.description}</:cell>
            <:cell>{todo.due}</:cell>
            <:cell>
              <.link navigate={~p"/todos/#{todo}"}>Show</.link>
               |
              <.link navigate={~p"/todos/#{todo}/edit"}>Edit</.link>
               |
              <.link
                phx-click={JS.push("delete", value: %{id: todo.id})}
                data-confirm="Are you sure?"
              >
                Delete
              </.link>
            </:cell>
          </.table_row>
        </.table_body>
      </.table>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Listing Todos")
     |> assign(:todos, list_todos())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    todo = Todos.get_todo!(id)
    {:ok, _} = Todos.delete_todo(todo)

    {:noreply, assign(socket, :todos, list_todos())}
  end

  defp list_todos() do
    Todos.list_todos()
  end
end
